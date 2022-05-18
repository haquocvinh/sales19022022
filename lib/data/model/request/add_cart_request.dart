// ignore: must_be_immutable
class AddOrderRequest {
  late String idProduct;
  late String quantity;
  late String checked;
  late String type;

  AddOrderRequest(
      {required this.idProduct,
      required this.quantity,
      required this.checked,
      required this.type}) {
    idProduct = idProduct;
    quantity = quantity;
    checked = checked;
    type = type;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_product'] = idProduct;
    data['quantity'] = quantity;
    data['checked'] = checked;
    data['type'] = type;
    return data;
  }
}
