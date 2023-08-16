import 'dart:convert';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/products.dart';
import '../res/app_url.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<Products> fetchMoviesList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.productsListEndPoint);
      return response = Products.fromJson(response[1]);


    } catch (e) {
      rethrow;
    }
  }
}
