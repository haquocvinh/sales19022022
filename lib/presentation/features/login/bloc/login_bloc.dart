import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phanam/common/app_constant.dart';
import 'package:phanam/data/local/share_pref.dart';
import 'package:phanam/data/model/response/user_response.dart';
import 'package:phanam/data/remote/response/app_response.dart';
import 'package:phanam/data/repository/authentication_repository.dart';
import 'package:phanam/presentation/features/login/bloc/login_event.dart';
import 'package:phanam/presentation/features/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LogInEventBase, LoginStateBase> {
  late AuthenticationRepository _repository;
  late SharePre _sharePre;

  LoginBloc({required AuthenticationRepository repository})
      : super(LoginStateInit()) {
    _repository = repository;
    _sharePre = SharePre.instance;

    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        Response response =
            await _repository.loginRepo(event.phone, event.password);
        AppResponse<UserResponse> userResponse =
            AppResponse.fromJson(response.data, UserResponse.fromJson);
        _sharePre.set(AppConstant.tokenCode, userResponse.data!.token!);
        emit(LoginSuccess(userResponse: userResponse.data!));
        //print(response.data.toString());
      } on DioError catch (e) {
        if (e.response != null) {
          //print(e);
          emit(LoginFail(message: e.response!.data['message'].toString()));
        } else {
          //print(e);
          emit(LoginFail(message: e.error.toString()));
        }
      } catch (e) {
        emit(LoginFail(message: e.toString()));
        //print(e.);
      }
    });
  }
}
