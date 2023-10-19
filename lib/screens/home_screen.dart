import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_snap/provider/product_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  void addProducts() async {
    final productProvider = context.read<ProductProvider>();
    await productProvider.fetch();
  }

  @override
  void initState() {
    addProducts();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "SHOP SNAP",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: productProvider.isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: searchController,
                          onChanged: (String value) {},
                          decoration: InputDecoration(
                            hintText: "Search....",
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.blueGrey,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.blueGrey,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                searchController.clear();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.clear_rounded,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        const Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    productProvider.categoryModelList.isEmpty
                        ? const Center(
                            child: Text("Categories is empty."),
                          )
                        : SizedBox(
                            height: 280,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    productProvider.categoryModelList.length,
                                itemBuilder: (context, index) {
                                  return CupertinoButton(
                                    onPressed: () {},
                                    child: Card(
                                      color: Colors.blueGrey.shade100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Image.network(
                                                productProvider
                                                    .categoryModelList[index]
                                                    .image!,
                                                height: 180, errorBuilder:
                                                    (BuildContext context,
                                                        Object exception,
                                                        StackTrace?
                                                            stackTrace) {
                                              return Image.network(
                                                "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                                                fit: BoxFit.cover,
                                                height: 180,
                                              );
                                            }),
                                            const SizedBox(height: 5),
                                            Text(
                                              productProvider
                                                  .categoryModelList[index].name
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                    SingleChildScrollView(
                      child: productProvider.productModelList.isEmpty == true
                          ? const Center(
                              child: Text("Products are empty!"),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Products",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GridView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount:
                                        productProvider.productModelList.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 14,
                                      crossAxisSpacing: 14,
                                      childAspectRatio: 0.62,
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (ctx, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey.shade100,
                                          border: Border.all(
                                            color: Colors.blueGrey.shade900,
                                            width: 1.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 12.0,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Image.network(
                                                productProvider
                                                    .productModelList[index]
                                                    .category!
                                                    .image
                                                    .toString(),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            const SizedBox(height: 12.0),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6.0,
                                              ),
                                              child: Text(
                                                productProvider
                                                    .productModelList[index]
                                                    .title
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Price: ₹${productProvider.productModelList[index].price}",
                                            ),
                                            const SizedBox(height: 6.0),
                                            SizedBox(
                                              height: 45.0,
                                              width: 140.0,
                                              child: OutlinedButton(
                                                onPressed: () {},
                                                child: const Text(
                                                  "Buy",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
