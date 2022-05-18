import 'package:equatable/equatable.dart';
import 'package:phanam/data/model/response/cart_response.dart';

// ignore: constant_identifier_names
enum CartStatus { initial, loading, fetchCartSuccess, fetchCartFail, AddQuantitySuccess, AddQuantityFail }

// ignore: must_be_immutable
class CartState extends Equatable {
  CartStatus? status;
  CartResponse? cartResponse;
  String? message;

  CartState._({this.status, this.cartResponse, this.message});

  CartState copyWith(
      {CartStatus? status, CartResponse? response, String? message}) {
    return CartState._(
      status: status ?? this.status,
      cartResponse: response ?? cartResponse,
      message: message ?? this.message,
    );
  }

  CartState.initial() : this._(status: CartStatus.initial);

  CartState.loading() : this._(status: CartStatus.loading);

  CartState.fetchCartSuccess({required CartResponse? cartResponse})
      : this._(
            status: CartStatus.fetchCartSuccess, cartResponse: cartResponse);

  CartState.fetchCartFail({required String? message})
      : this._(status: CartStatus.fetchCartFail, message: message);

  // ignore: non_constant_identifier_names
  CartState.AddQuantitySuccess({required CartResponse? cartResponse})
      : this._(
      status: CartStatus.AddQuantitySuccess, cartResponse: cartResponse);

  // ignore: non_constant_identifier_names
  CartState.AddQuantityFail({required String? message})
      : this._(status: CartStatus.AddQuantityFail, message: message);

  @override
  List<Object?> get props => [status, cartResponse, message];
}

