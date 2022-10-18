import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:q/repositories/product_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../configurations/api_configuration.dart';
import '../models/productModel.dart';

class ProductRepository implements ProductRepositoryInterface {
  @override
  Future<List<ProductModel>> getAllProducts(int currentPage) async {
    String? token;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('token');

    var response = await http.get(
      Uri.parse("${ApiConfiguration.BASE_URL}/api/products?page=$currentPage"),
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print("token: $token");
      var jsonResponse = json.decode(response.body);

      int last_page = (json.decode(response.body)['last_page']);
      preferences.setInt('last_page', jsonResponse['last_page']);
      preferences.setInt('current_page', jsonResponse['current_page']);
      Map data = {'current_page': currentPage, 'last_page': last_page};
      print("Current Page: $currentPage");
      print("Last Page: $last_page");

      var jsonProducts = jsonResponse['data'];
      List<ProductModel> products = [];
      for (var jsonProduct in jsonProducts) {
        ProductModel product = ProductModel.fromJson(jsonProduct);
        products.add(product);
      }
      return products;
    } else {
      return <ProductModel>[];
    }
  }

  @override
  Future<ProductModel?> getSingleProducts(int id) async {
    String? token;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('token');
    var response = await http.get(
      Uri.parse("${ApiConfiguration.BASE_URL}/api/products/$id"),
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Get a Product');
    }
  }

  static Future<ProductModel> addProduct(String name, imagelink, price) async {
    var jsonResponse;
    Map data = {
      'name': name,
      'image_link': imagelink,
      // 'description': product.description,
      'price': price
    };
    String? token;
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    String body = json.encode(data);
    Uri url = Uri.parse("${ApiConfiguration.BASE_URL}/api/products");
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: 10));

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      // jsonResponse = json.decode(response.body.toString());
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Add a Product');
    }
  }

  @override
  Future<ProductModel?> editProduct(
      int id, String name, imagelink, price) async {
    var jsonResponse;
    Map data = {
      'id': id,
      'name': name,
      'image_link': imagelink,
      'price': price,
      'is_published': true
    };

    String? token;
    final preferences = await SharedPreferences.getInstance();
    token = preferences.getString('token');

    String body = json.encode(data);
    Uri url = Uri.parse("${ApiConfiguration.BASE_URL}/api/products/$id");
    var response = await http.put(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: 10));

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      // jsonResponse = json.decode(response.body.toString());
      ProductModel.fromJson(jsonDecode(response.body.toString()));
    } else {
      throw Exception('Failed to Edit a Product');
    }
    return null;
  }

  @override
  Future<void> deleteProduct(String id) async {
    var jsonResponse;

    String? token;
    final preferences = await SharedPreferences.getInstance();
    token = preferences.getString('token');

    Uri url = Uri.parse("${ApiConfiguration.BASE_URL}/api/products/$id");
    var response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer $token',
      },
    ).timeout(Duration(seconds: 10));

    if (response.statusCode == 201) {
      print("Deleted");
    } else {
      throw Exception('Failed to Delete a Product');
    }
  }
}
