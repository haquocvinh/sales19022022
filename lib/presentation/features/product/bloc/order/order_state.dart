import 'package:equatable/equatable.dart';
import 'package:phanam/data/model/response/order_response.dart';

// ignore: must_be_immutable
abstract class OrderStateBase extends Equatable {
  OrderResponse? orderResponse;

  OrderStateBase({OrderResponse? orderResponse});

  @override
  // TODO: implement props
  List<Object?> get props => [orderResponse];
}

// ignore: must_be_immutable
class OrderStateInit extends OrderStateBase {}

// ignore: must_be_immutable
class FetchOrderSuccess extends OrderStateBase {
  FetchOrderSuccess.copyWith({OrderResponse? data}) {
    orderResponse = data;
  }

  @override
  List<Object?> get props => [orderResponse];
}

// ignore: must_be_immutable
class FetchOrderFail extends OrderStateBase {
  late String message;

  FetchOrderFail(this.message);

  @override
  List<Object?> get props => [message];
}

// ignore: must_be_immutable
class AddOrderSuccess extends OrderStateBase {
  AddOrderSuccess.copyWith({OrderResponse? data}) {
    orderResponse = data;
  }

  @override
  List<Object?> get props => [orderResponse];
}

// ignore: must_be_immutable
class AddOrderFail extends OrderStateBase {
  late String message;

  AddOrderFail(this.message);

  @override
  List<Object?> get props => [message];
}
