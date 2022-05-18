import 'package:dio/dio.dart';
import 'package:phanam/data/model/request/add_quantity_request.dart';
import 'package:phanam/data/remote/client/dio_client.dart';

class QuantityRequest {
  late Dio _dio;

  QuantityRequest() {
    _dio = DioClient.instance.dio;
  }

  Future<Response> fetchQuantity() {
    return _dio.post("order/get-cart");
  }

  Future<Response> addQuantity(AddQuantityRequest addQuantityRequest) {
    return _dio.post("order/update-cart", data: addQuantityRequest.toJson());
  }
}
