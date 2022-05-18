import 'package:phanam/data/model/response/product_response.dart';

class CartResponse {
  int? total;
  int? idCustomerOa;
  int? idCustomer;
  int? totalQuantity;
  int? totalAmount;
  List<ProductResponse>? carts;

  CartResponse(
      {this.total,
      this.idCustomerOa,
      this.idCustomer,
      this.totalQuantity,
      this.totalAmount,
      this.carts});

  CartResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    idCustomerOa = json['id_customer_oa'];
    idCustomer = json['id_customer'];
    totalQuantity = json['total_quantity'];
    totalAmount = json['total_amount'];
    if (json['carts'] != null) {
      carts = <ProductResponse>[];
      json['carts'].forEach((v) {
        carts!.add(ProductResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['id_customer_oa'] = idCustomerOa;
    data['id_customer'] = idCustomer;
    data['total_quantity'] = totalQuantity;
    data['total_amount'] = totalAmount;
    if (carts != null) {
      data['carts'] = carts!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'CartResponse{idCustomerOa: $idCustomerOa, idCustomer:$idCustomer, carts: $Carts, totalAmount: $totalAmount}';
  }

  static CartResponse formJson(Map<String, dynamic> json) {
    return CartResponse.fromJson(json);
  }
}

class Carts {
  int? idProduct;
  String? productName;
  String? productImage;
  int? productPrice;
  String? unitName;
  int? vat;
  int? quantity;
  int? checked;
  int? type;
  String? codeId;
  int? idCustomerOa;

  Carts(
      {this.idProduct,
      this.productName,
      this.productImage,
      this.productPrice,
      this.unitName,
      this.vat,
      this.quantity,
      this.checked,
      this.type,
      this.codeId,
      this.idCustomerOa});

  Carts.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    unitName = json['unit_name'];
    vat = json['vat'];
    quantity = json['quantity'];
    checked = json['checked'];
    (json['type'] != null)
        ? type = json['type']
        : type = 0; //API backend tự update 1 nếu cart tồn tại product
    codeId = json['code_id'];
    idCustomerOa = json['id_customer_oa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_product'] = idProduct;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['product_price'] = productPrice;
    data['unit_name'] = unitName;
    data['vat'] = vat;
    data['quantity'] = quantity;
    data['checked'] = checked;
    data['type'] = type;
    data['code_id'] = codeId;
    data['id_customer_oa'] = idCustomerOa;
    return data;
  }

  @override
  String toString() {
    return 'CartResponse{idProduct: $idProduct, quantity: $quantity, checked: $checked, type: $type}';
  }

  static CartResponse formJson(Map<String, dynamic> json) {
    return CartResponse.fromJson(json);
  }
}
