import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_task/view/product_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import '../data/response/status.dart';
import '../model/products.dart';
import '../utils/utils.dart';
import '../view_model/home_view_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  HomeViewModel homeViewViewModel = HomeViewModel();
  late List<Products> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // here the desired height,
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            style: TextStyle(
                color: Colors.black, fontStyle: FontStyle.normal, fontSize: 34),
            'All Products',
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewModel>(builder: (context, value, _) {
          switch (value.moviesList.status) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(value.moviesList.message.toString()));
            case Status.COMPLETED:
              return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print('Item clicked: ${products[index].title}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductItem(
                                    product: products[index])));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  height: 370,
                                  alignment: Alignment.center,
                                  products[index].image.toString(),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Text(
                                  products[index].price.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: RatingBarIndicator(
                                  rating:
                                      products![index].rating!.rate!.toDouble(),
                                  itemCount: 5,
                                  itemSize: 30.0,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                              )
                            ]),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                products[index].title.toString(),
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey),
                              ),
                            ),
                            Text(products[index].description.toString())
                          ],
                        ),
                      ),
                    );
                  });
            case null:
            // TODO: Handle this case.
          }
          return Container();
        }),
      ),
    );
  }

  @override
  void initState() {
    FetchData();
    homeViewViewModel.fetchMoviesListApi();
  }

  Future<void> FetchData() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      products = jsonResponse.map((x) => Products.fromJson(x)).toList();

      // Now you can work with the list of Product objects
      for (var product in products) {
        print('Title: ${product.title}');
        print('Price: ${product.price}');
        print('Description: ${product.description}');
        print('Category: ${product.category}');
        print('Image: ${product.image}');
        print(
            'Rating: ${product.rating!.rate} (${product.rating!.count} ratings)');
        print('-----------------------------');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
