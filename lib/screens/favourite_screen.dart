import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/favourite_provider.dart';
import 'widgets/single_favourite_item.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favouriteProvider = context.watch<FavouriteProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Favourite Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          onPressed: () {
            favouriteProvider.clearFavourite();
          },
          label: const Text(
            'Remove all Favourites',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          icon: const Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          backgroundColor: Colors.red.shade300,
        ),
      ),
      body: favouriteProvider.favouriteList!.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: favouriteProvider.favouriteList!.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (ctx, index) {
                return SingleFavouriteItem(
                  singleProduct: favouriteProvider.favouriteList![index],
                );
              },
            ),
    );
  }
}
