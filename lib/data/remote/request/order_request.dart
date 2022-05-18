import 'package:dio/dio.dart';
import 'package:phanam/data/model/request/add_cart_request.dart';
import 'package:phanam/data/remote/client/dio_client.dart';

class OrderRequest {
  late Dio _dio;

  OrderRequest() {
    _dio = DioClient.instance.dio;
  }

  Future<Response> fetchOrder() {
    return _dio.post("order/get-cart");
  }

  Future<Response> addOrder(AddOrderRequest addCartRequest) {
    return _dio.post("order/update-cart", data: addCartRequest.toJson());
  }
}
