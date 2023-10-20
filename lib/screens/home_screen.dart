import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_snap/provider/product_provider.dart';
import 'package:shop_snap/screens/category_view_screen.dart';
import 'package:shop_snap/screens/favourite_screen.dart';
import 'package:shop_snap/screens/product_detail_screen.dart';
import '../constants/routes.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const FavouriteScreen(), context: context);
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red.shade200,
            ),
          ),
        ],
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
// TEXTFORMFIELD
                        TextFormField(
                          controller: searchController,
                          onChanged: (String value) async {
                            await productProvider.filterProductsByTitle(value);
                          },
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
                                productProvider.searchTitleList.clear();
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
// CATEGORIES DISPLAYED HERE
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
                                    onPressed: () {
                                      Routes.instance.push(
                                          widget: CategoryViewScreen(
                                            id: productProvider
                                                .categoryModelList[index].id!,
                                            name: productProvider
                                                .categoryModelList[index].name
                                                .toString(),
                                          ),
                                          context: context);
                                    },
                                    child: Card(
                                      color: Colors.blueGrey.shade100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 180,
                                              child: Image.network(
                                                productProvider
                                                    .categoryModelList[index]
                                                    .image!,
                                                fit: BoxFit.contain,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return const Padding(
                                                    padding: EdgeInsets.all(33),
                                                    child: Center(
                                                      child: Text(
                                                          "No image found!"),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
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
                    const Text(
                      "Products",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
// IF SEARCHCONTROLLER NOT EMPTY THEN SHOW THE PRODUCTS WITH SEARCHED TITLE
                    searchController.text.isNotEmpty &&
                            productProvider.searchTitleList.isEmpty
                        ? const Center(
                            child: Text("No product found"),
                          )
                        : productProvider.searchTitleList.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    productProvider.searchTitleList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 14,
                                  crossAxisSpacing: 14,
                                  childAspectRatio: 0.55,
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
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: SizedBox(
                                            height: 180,
                                            child: Image.network(
                                              productProvider
                                                  .searchTitleList[index]
                                                  .images![0]
                                                  .toString(),
                                              fit: BoxFit.contain,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Image.network(
                                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                                                  width: 300,
                                                  height: 150,
                                                  fit: BoxFit.contain,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12.0),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6.0,
                                          ),
                                          child: Text(
                                            productProvider
                                                .searchTitleList[index].title
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
                                          "Price: ₹${productProvider.searchTitleList[index].price}",
                                        ),
                                        const SizedBox(height: 6.0),
                                        SizedBox(
                                          height: 45.0,
                                          width: 140.0,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Routes.instance.push(
                                                  widget: ProductDetailScreen(
                                                    productDetail:
                                                        productProvider
                                                                .searchTitleList[
                                                            index],
                                                  ),
                                                  context: context);
                                            },
                                            child: const Text(
                                              "Buy",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
// ALL PRODUCTS FETCHED HERE
                            : SingleChildScrollView(
                                child: productProvider
                                            .productModelList.isEmpty ==
                                        true
                                    ? const Center(
                                        child: Text("Products are empty!"),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              itemCount: productProvider
                                                  .productModelList.length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 14,
                                                crossAxisSpacing: 14,
                                                childAspectRatio: 0.55,
                                                crossAxisCount: 2,
                                              ),
                                              itemBuilder: (ctx, index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors
                                                        .blueGrey.shade100,
                                                    border: Border.all(
                                                      color: Colors
                                                          .blueGrey.shade900,
                                                      width: 1.5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 12.0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    12.0),
                                                        child: SizedBox(
                                                          height: 180,
                                                          child: Image.network(
                                                            productProvider
                                                                .productModelList[
                                                                    index]
                                                                .images![0]
                                                                .toString(),
                                                            fit: BoxFit.contain,
                                                            errorBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              return Image
                                                                  .network(
                                                                "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                                                                width: 300,
                                                                height: 150,
                                                                fit: BoxFit
                                                                    .contain,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 12.0),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 6.0,
                                                        ),
                                                        child: Text(
                                                          productProvider
                                                              .productModelList[
                                                                  index]
                                                              .title
                                                              .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Price: ₹${productProvider.productModelList[index].price}",
                                                      ),
                                                      const SizedBox(
                                                          height: 6.0),
                                                      SizedBox(
                                                        height: 45.0,
                                                        width: 140.0,
                                                        child: OutlinedButton(
                                                          onPressed: () {
                                                            Routes.instance
                                                                .push(
                                                                    widget:
                                                                        ProductDetailScreen(
                                                                      productDetail:
                                                                          productProvider
                                                                              .productModelList[index],
                                                                    ),
                                                                    context:
                                                                        context);
                                                          },
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
