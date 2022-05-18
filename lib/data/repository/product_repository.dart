import 'package:dio/dio.dart';
import 'package:phanam/data/remote/request/product_request.dart';

class ProductRepository {
  late ProductRequest _request;

  ProductRepository();

  void updateProductRequest({required ProductRequest request}) {
    _request = request;
  }

  Future<Response> fetchProducts() {
    return _request.fetchListProduct();
  }
}
