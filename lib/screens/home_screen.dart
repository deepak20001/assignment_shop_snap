import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(),
            ),
          ],
        ),
      ),
    );
  }
}
