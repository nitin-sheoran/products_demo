// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:products_demo/products/model/product_model.dart';
// import 'package:products_demo/products/model/products_model.dart';
//
// class ProductService {
//   static Future<List<Products>> getProductService() async {
//     http.Response response = await http.get(
//       Uri.parse('https://dummyjson.com/products'),
//     );
//
//     if (response.statusCode == 200) {
//       List<dynamic> mapList = jsonDecode(response.body);
//       List<Products> productList = [];
//
//       for (int i = 0; i < mapList.length; i++) {
//         Products product = Products.fromJson(mapList[i]);
//         productList.add(product);
//       }
//       return productList;
//     }
//     throw 'Something went wrong';
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:products_demo/products/model/product_model.dart';
import 'package:products_demo/products/service/ProductResponseList.dart';

class ProductApiService{
  static Future<List<Products>> getProductInfo() async {
    String url = 'https://dummyjson.com/products';
    http.Response response = await http.get(
      Uri.parse(url),

    );
    if (response.statusCode == 200) {
      String body = response.body;
      final data = jsonDecode(body);

      ProductResponseList productResponseList= ProductResponseList.fromJson(data);
      return productResponseList.products;
    } else {
      throw 'Something went wrong';
    }
  }
}
