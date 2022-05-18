import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phanam/data/model/response/cart_response.dart';
import 'package:phanam/data/remote/response/app_response.dart';
import 'package:phanam/data/repository/cart_repository.dart';
import 'package:phanam/presentation/features/cart/bloc/cart_event.dart';
import 'package:phanam/presentation/features/cart/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEventBase, CartState> {
  late QuantityRepository _quantityRepository;

  CartBloc({required QuantityRepository quantityRepository})
      : super(CartState.initial()) {
    _quantityRepository = quantityRepository;
    on<FetchCartEvent>((event, emit) async {
      emit(CartState.loading());
      try {
        Response response = await _quantityRepository.fetchQuantity();
        AppResponse<CartResponse> cartResponse =
            AppResponse.fromJson(response.data, CartResponse.fromJson);
        emit(CartState.fetchCartSuccess(cartResponse: cartResponse.data!));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(CartState.fetchCartFail(
              message: e.response!.data['message'].toString()));
        } else {
          emit(CartState.fetchCartFail(message: e.toString()));
        }
      } catch (e) {
        emit(CartState.fetchCartFail(message: e.toString()));
      }
    });

    on<AddQuantity>((event, emit) async {
      try {
        Response response = await _quantityRepository.addQuantity(
            event.idProduct, event.quantity, event.checked, event.type);
        AppResponse<CartResponse> cartResponse =
        AppResponse.fromJson(response.data, CartResponse.fromJson);
        emit(CartState.AddQuantitySuccess(cartResponse: cartResponse.data!));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(CartState.AddQuantityFail(message: e.response!.data['message'].toString()));
        } else {
          emit(CartState.AddQuantityFail(message: e.error.toString()));
        }
      } catch (e) {
        emit(CartState.AddQuantityFail(message: e.toString()));
      }
    });
  }
}
