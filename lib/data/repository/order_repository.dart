import 'package:dio/dio.dart';
import 'package:phanam/data/model/request/add_cart_request.dart';
import 'package:phanam/data/remote/request/order_request.dart';

class OrderRepository {
  late OrderRequest _request;

  OrderRepository();

  void updateOrderRequest({required OrderRequest request}) {
    _request = request;
  }

  Future<Response> fetchOrder() {
    return _request.fetchOrder();
  }

  Future<Response> addOrder(
      String idProduct, String quantity, String checked, String type) {
    return _request.addOrder(AddOrderRequest(
        idProduct: idProduct,
        quantity: quantity,
        checked: checked,
        type: type));
  }
}
