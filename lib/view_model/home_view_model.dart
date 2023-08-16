

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

import '../data/response/api_response.dart';
import '../model/products.dart';
import '../respository/home_repository.dart';


class HomeViewModel with ChangeNotifier {

  final _myRepo = HomeRepository();

  ApiResponse<Products> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<Products> response){
    moviesList = response ;
    notifyListeners();
  }

  Future<void> fetchData() async {

    final response =
    await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<Products> products =
      jsonResponse.map((x) => Products.fromJson(x)).toList();

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
  Future<void> fetchMoviesListApi ()async{

    setMoviesList(ApiResponse.loading());

    _myRepo.fetchMoviesList().then((value){

      setMoviesList(ApiResponse.completed(value as Products?));

    }).onError((error, stackTrace){

      setMoviesList(ApiResponse.error(error.toString()));

    });
  }


}