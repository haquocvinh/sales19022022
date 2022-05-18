import 'package:dio/dio.dart';
import 'package:phanam/common/app_constant.dart';
import 'package:phanam/data/local/share_pref.dart';

class DioClient {
  Dio? _dio;
  static final BaseOptions _options = BaseOptions(
    baseUrl: AppConstant.baseURL,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static final DioClient instance = DioClient._internal();

  DioClient._internal() {
    if (_dio == null) {
      _dio = Dio(_options);
      _dio!.interceptors.add(LogInterceptor(requestBody: true));
      _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          var tokenCode = await SharePre.instance.get("token");
          if (tokenCode != null) {
            options.headers["Authorization"] = "Bearer " + tokenCode;
          }
          return handler.next(options);
        },
        onResponse: (e, handler) {
          return handler.next(e);
        },
        onError: (e, handler) {
          return handler.next(e);
        },
      ));
    }
  }

  Dio get dio => _dio!;
}
