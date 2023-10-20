// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../main.dart';
import '../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel? productDetail;
  const ProductDetailScreen({
    Key? key,
    this.productDetail,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int qty = 0;
  final CarouselController carouselController = CarouselController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    print(activeIndex);
                  },
                  child: CarouselSlider(
                    items: widget.productDetail!.images!
                        .map(
                          (i) => Builder(
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Image.network(
                                  i,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 1,
                        viewportFraction: 0.89,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        }),
                  ),
                ),
                Positioned(
                  bottom: mq.height * .02,
                  left: mq.width * .4,
                  child: buildIndicator(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    widget.productDetail!.title.toString(),
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                  ),
                ),
              ],
            ),
            Text(
              widget.productDetail!.description.toString(),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    if (qty >= 1) {
                      setState(() {
                        qty--;
                      });
                    }
                  },
                  child: Icon(
                    Icons.remove_circle,
                    size: 40.0,
                    color: Colors.blueGrey.shade600,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Text(
                  qty.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                CupertinoButton(
                  onPressed: () {
                    setState(() {
                      qty++;
                    });
                  },
                  child: Icon(
                    Icons.add_circle,
                    size: 40.0,
                    color: Colors.blueGrey.shade600,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text("ADD TO CART"),
                  ),
                  const SizedBox(
                    width: 24.0,
                  ),
                  SizedBox(
                    height: 38,
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("BUY"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.productDetail!.images!.length,
        effect: const SlideEffect(
          strokeWidth: 1.5,
          dotColor: Colors.white,
          activeDotColor: Colors.black,
          paintStyle: PaintingStyle.fill,
        ),
      );
}
