class ProductResponse {
  int? idProduct;
  String? codeId;
  String? productName;
  String? productImage;
  int? productPrice;
  int? vat;
  int? quantity;
  int? checked;
  int? type;
  int? idCategory;
  String? unitName;
  int? active;
  String? moreInformation;
  String? lngredient;
  String? uses;
  String? usageDosage;
  String? packing;

  ProductResponse(
      {this.idProduct,
      this.codeId,
      this.productName,
      this.productImage,
      this.productPrice,
      this.vat,
      this.quantity,
      this.checked,
      this.type,
      this.idCategory,
      this.unitName,
      this.active,
      this.moreInformation,
      this.lngredient,
      this.uses,
      this.usageDosage,
      this.packing});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    codeId = json['code_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    vat = json['vat'];
    (json['quantity'] != null) ? quantity = json['quantity'] : quantity = 1;
    (json['checked'] != null) ? checked = json['checked'] : checked = 1;
    (json['type'] != null)
        ? type = json['type']
        : type = 1; //API backend tự update 1 nếu cart tồn tại product
    idCategory = json['id_category'];
    unitName = json['unit_name'];
    active = json['active'];
    moreInformation = json['more_information'];
    lngredient = json['lngredient'];
    uses = json['uses'];
    usageDosage = json['usage_dosage'];
    packing = json['packing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_product'] = idProduct;
    data['code_id'] = codeId;
    data['product_name'] = productName;
    data['product_image'] = productImage;
    data['product_price'] = productPrice;
    data['vat'] = vat;
    data['quantity'] = quantity;
    data['checked'] = checked;
    data['type'] = type;
    data['id_category'] = idCategory;
    data['unit_name'] = unitName;
    data['active'] = active;
    data['more_information'] = moreInformation;
    data['lngredient'] = lngredient;
    data['uses'] = uses;
    data['usage_dosage'] = usageDosage;
    data['packing'] = packing;
    return data;
  }
}
