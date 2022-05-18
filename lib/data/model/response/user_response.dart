class UserResponse {
  String? codeId;
  String? customerName;
  String? customerAddress;
  String? customerInvAddress;
  String? taxCode;
  String? deliveryAddress;
  String? email;
  List<Images>? images;
  List<FileBusiness>? fileBusiness;
  List<FileGdp>? fileGdp;
  String? dateDelivery;
  int? idCustomerOa;
  int? idCustomer;
  String? userName;
  String? userAddress;
  int? userGender;
  String? userCode;
  String? userPhone;
  String? userAvatar;
  int? idCustomerRole;
  String? userBirthday;
  String? userEmail;
  String? token;

  UserResponse(
      {this.codeId,
      this.customerName,
      this.customerAddress,
      this.customerInvAddress,
      this.taxCode,
      this.deliveryAddress,
      this.email,
      this.images,
      this.fileBusiness,
      this.fileGdp,
      this.dateDelivery,
      this.idCustomerOa,
      this.idCustomer,
      this.userName,
      this.userAddress,
      this.userGender,
      this.userCode,
      this.userPhone,
      this.userAvatar,
      this.idCustomerRole,
      this.userBirthday,
      this.userEmail,
      this.token});

  UserResponse.fromJson(Map<String, dynamic> json) {
    codeId = json['code_id'];
    customerName = json['customer_name'];
    customerAddress = json['customer_address'];
    customerInvAddress = json['customer_inv_address'];
    taxCode = json['tax_code'];
    deliveryAddress = json['delivery_address'];
    (email != null) ? email = json['email'] : email = "";
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['file_business'] != null) {
      fileBusiness = <FileBusiness>[];
      json['file_business'].forEach((v) {
        fileBusiness!.add(FileBusiness.fromJson(v));
      });
    }
    if (json['file_gdp'] != null) {
      fileGdp = <FileGdp>[];
      json['file_gdp'].forEach((v) {
        fileGdp!.add(FileGdp.fromJson(v));
      });
    }
    dateDelivery = json['date_delivery'];
    idCustomerOa = json['id_customer_oa'];
    idCustomer = json['id_customer'];
    userName = json['user_name'];
    userAddress = json['user_address'];
    userGender = json['user_gender'];
    (userCode != null) ? userCode = json['user_code'] : userCode = "";
    userPhone = json['user_phone'];
    (userAvatar != null) ? userAvatar = json['user_code'] : userAvatar = "";
    idCustomerRole = json['id_customer_role'];
    userBirthday = json['user_birthday'];
    (userEmail != null) ? userEmail = json['user_code'] : userEmail = "";
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code_id'] = codeId;
    data['customer_name'] = customerName;
    data['customer_address'] = customerAddress;
    data['customer_inv_address'] = customerInvAddress;
    data['tax_code'] = taxCode;
    data['delivery_address'] = deliveryAddress;
    data['email'] = email;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (fileBusiness != null) {
      data['file_business'] = fileBusiness!.map((v) => v.toJson()).toList();
    }
    if (fileGdp != null) {
      data['file_gdp'] = fileGdp!.map((v) => v.toJson()).toList();
    }
    data['date_delivery'] = dateDelivery;
    data['id_customer_oa'] = idCustomerOa;
    data['id_customer'] = idCustomer;
    data['user_name'] = userName;
    data['user_address'] = userAddress;
    data['user_gender'] = userGender;
    data['user_code'] = userCode;
    data['user_phone'] = userPhone;
    data['user_avatar'] = userAvatar;
    data['id_customer_role'] = idCustomerRole;
    data['user_birthday'] = userBirthday;
    data['user_email'] = userEmail;
    data['token'] = token;
    return data;
  }
}

class Images {
  int? idFile;
  int? idCustomer;
  String? name;
  String? fileName;
  String? url;
  String? extname;
  int? size;
  String? mimeType;
  int? active;
  String? createdAt;

  Images(
      {this.idFile,
      this.idCustomer,
      this.name,
      this.fileName,
      this.url,
      this.extname,
      this.size,
      this.mimeType,
      this.active,
      this.createdAt});

  Images.fromJson(Map<String, dynamic> json) {
    idFile = json['id_file'];
    idCustomer = json['id_customer'];
    name = json['name'];
    fileName = json['file_name'];
    url = json['url'];
    extname = json['extname'];
    size = json['size'];
    mimeType = json['mime_type'];
    active = json['active'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_file'] = idFile;
    data['id_customer'] = idCustomer;
    data['name'] = name;
    data['file_name'] = fileName;
    data['url'] = url;
    data['extname'] = extname;
    data['size'] = size;
    data['mime_type'] = mimeType;
    data['active'] = active;
    data['created_at'] = createdAt;
    return data;
  }
}

class FileBusiness {
  int? idFile;
  int? idCustomer;
  String? name;
  String? fileName;
  String? url;
  String? extname;
  int? size;
  String? mimeType;
  int? active;
  String? createdAt;

  FileBusiness(
      {idFile,
      this.idCustomer,
      this.name,
      this.fileName,
      this.url,
      this.extname,
      this.size,
      this.mimeType,
      this.active,
      this.createdAt});

  FileBusiness.fromJson(Map<String, dynamic> json) {
    idFile = json['id_file'];
    idCustomer = json['id_customer'];
    name = json['name'];
    fileName = json['file_name'];
    url = json['url'];
    extname = json['extname'];
    size = json['size'];
    mimeType = json['mime_type'];
    active = json['active'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_file'] = idFile;
    data['id_customer'] = idCustomer;
    data['name'] = name;
    data['file_name'] = fileName;
    data['url'] = url;
    data['extname'] = extname;
    data['size'] = size;
    data['mime_type'] = mimeType;
    data['active'] = active;
    data['created_at'] = createdAt;
    return data;
  }
}

class FileGdp {
  int? idFile;
  int? idCustomer;
  String? name;
  String? fileName;
  String? url;
  String? extname;
  int? size;
  String? mimeType;
  int? active;
  String? createdAt;

  FileGdp(
      {this.idFile,
      this.idCustomer,
      this.name,
      this.fileName,
      this.url,
      this.extname,
      this.size,
      this.mimeType,
      this.active,
      this.createdAt});

  FileGdp.fromJson(Map<String, dynamic> json) {
    idFile = json['id_file'];
    idCustomer = json['id_customer'];
    name = json['name'];
    fileName = json['file_name'];
    url = json['url'];
    extname = json['extname'];
    size = json['size'];
    mimeType = json['mime_type'];
    active = json['active'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_file'] = idFile;
    data['id_customer'] = idCustomer;
    data['name'] = name;
    data['file_name'] = fileName;
    data['url'] = url;
    data['extname'] = extname;
    data['size'] = size;
    data['mime_type'] = mimeType;
    data['active'] = active;
    data['created_at'] = createdAt;
    return data;
  }
}
