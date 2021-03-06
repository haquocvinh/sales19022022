import 'package:dio/dio.dart';
import 'package:phanam/data/model/request/login_request.dart';
import 'package:phanam/data/model/request/sign_up_request.dart';
import 'package:phanam/data/remote/client/dio_client.dart';

class AuthenticationRequest {
  late Dio _dio;

  AuthenticationRequest() {
    _dio = DioClient.instance.dio;
  }

  Future<Response> loginRequest(LoginRequest loginRequest) {
    return _dio.post("auth/sign-in", data: loginRequest.toJson());
  }

  Future<Response> signUpRequest(SignUpRequest signUpRequest) {
    return _dio.post("user/sign-up", data: signUpRequest.toJson());
  }
}
