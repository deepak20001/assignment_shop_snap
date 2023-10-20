import 'package:flutter/material.dart';
import 'package:shop_snap/models/product_model.dart';
import 'package:shop_snap/screens/product_detail_screen.dart';
import '../../constants/routes.dart';

class SingleFavouriteItem extends StatelessWidget {
  final ProductModel singleProduct;
  const SingleFavouriteItem({super.key, required this.singleProduct});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes.instance.push(
            widget: ProductDetailScreen(productDetail: singleProduct),
            context: context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12,
          ),
          border: Border.all(
            color: Colors.blueGrey.shade100,
            width: 3.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 140,
                color: Colors.blueGrey.shade100,
                child: Image.network(
                  singleProduct.images![0].toString(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 140,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          singleProduct.title!,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "₹${singleProduct.price.toString()}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
