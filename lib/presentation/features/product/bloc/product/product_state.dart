import 'package:equatable/equatable.dart';
import 'package:phanam/data/model/response/product_response.dart';

abstract class ProductStateBase extends Equatable {}

class ProductStateInit extends ProductStateBase {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class FetchProductsSuccess extends ProductStateBase {
  late List<ProductResponse> list;

  FetchProductsSuccess({required this.list});

  @override
  List<Object?> get props => [list];
}

// ignore: must_be_immutable
class FetchProductsError extends ProductStateBase {
  late String message;

  FetchProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
