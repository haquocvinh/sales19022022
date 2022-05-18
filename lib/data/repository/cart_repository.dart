import 'package:dio/dio.dart';
import 'package:phanam/data/model/request/add_quantity_request.dart';
import 'package:phanam/data/remote/request/quantity_request.dart';

class QuantityRepository {
  late QuantityRequest _request;

  QuantityRepository();

  void updateQuantityRequest({required QuantityRequest request}) {
    _request = request;
  }

  Future<Response> fetchQuantity() {
    return _request.fetchQuantity();
  }

  Future<Response> addQuantity(
      String idProduct, String quantity, String checked, String type) {
    return _request.addQuantity(AddQuantityRequest(
        idProduct: idProduct,
        quantity: quantity,
        checked: checked,
        type: type));
  }
}