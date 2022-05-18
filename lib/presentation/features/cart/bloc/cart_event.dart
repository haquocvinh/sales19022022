import 'package:equatable/equatable.dart';

abstract class CartEventBase extends Equatable {}

class FetchCartEvent extends CartEventBase {
  FetchCartEvent();

  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class AddQuantity extends CartEventBase {
  late String idProduct;
  late String quantity;
  late String checked;
  late String type;

  AddQuantity(
      {required this.idProduct,
        required this.quantity,
        required this.checked,
        required this.type});

  @override
  List<Object?> get props => [idProduct, quantity, checked, type];
}