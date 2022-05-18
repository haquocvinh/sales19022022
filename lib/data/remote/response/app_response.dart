class AppResponse<T> {
  bool? status;
  T? data;
  String? message;

  AppResponse.fromJson(Map<String, dynamic> json, Function fromJsonModel) {
    status = json['status']; //result
    if (fromJsonModel(json['data']) != null) {
      data = fromJsonModel(json['data']); //data
    }
    message = json['message']; //message
  }
}
