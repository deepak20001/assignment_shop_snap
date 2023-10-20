// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_snap/screens/product_detail_screen.dart';
import '../constants/routes.dart';
import '../provider/product_provider.dart';

class CategoryViewScreen extends StatefulWidget {
  final int id;
  final String name;
  const CategoryViewScreen({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  State<CategoryViewScreen> createState() => _CategoryViewScreenState();
}

class _CategoryViewScreenState extends State<CategoryViewScreen> {
  void addProducts() async {
    final productProvider = context.read<ProductProvider>();
    await productProvider.filterProductsByCategory(widget.id);
  }

  @override
  void initState() {
    addProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      body: SafeArea(
        child: productProvider.isLoadingCategory == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const BackButton(),
                          Text(
                            widget.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    productProvider.categoryProductsList.isEmpty
                        ? const Center(
                            child: Text("Best Product is empty"),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount:
                                  productProvider.categoryProductsList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                childAspectRatio: 0.72,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (ctx, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade100,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Image.network(
                                        productProvider
                                                .categoryProductsList.isNotEmpty
                                            ? productProvider
                                                .categoryProductsList[index]
                                                .images![0]
                                            : "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.contain,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return const Padding(
                                            padding: EdgeInsets.all(33),
                                            child: Center(
                                              child: Text("No image found!"),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Text(
                                        productProvider
                                            .categoryProductsList[index].title!,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          "Price: \$${productProvider.categoryProductsList[index].price}"),
                                      const SizedBox(
                                        height: 18.0,
                                      ),
                                      SizedBox(
                                        height: 45.0,
                                        width: 140.0,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Routes.instance.push(
                                                widget: ProductDetailScreen(
                                                  productDetail: productProvider
                                                          .categoryProductsList[
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
                              },
                            ),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
