import 'package:dio/dio.dart';
import 'package:phanam/data/remote/client/dio_client.dart';

class ProductRequest {
  late Dio _dio;

  ProductRequest() {
    _dio = DioClient.instance.dio;
  }

  Future<Response> fetchListProduct() {
    return _dio.get("products");
  }
}
