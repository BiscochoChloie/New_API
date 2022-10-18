import '../models/productModel.dart';

abstract class ProductRepositoryInterface {
  Future<List<ProductModel>> getAllProducts(int currentPage);
  Future<ProductModel?> getSingleProducts(int id);
  Future<ProductModel?> editProduct(int id, String name, imagelink, price);
  Future<void> deleteProduct(String id);
}
