import 'package:equatable/equatable.dart';

abstract class OrderEventBase extends Equatable {}

class FetchOrder extends OrderEventBase {
  FetchOrder();

  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class AddOrder extends OrderEventBase {
  late String idProduct;
  late String quantity;
  late String checked;
  late String type;

  AddOrder(
      {required this.idProduct,
      required this.quantity,
      required this.checked,
      required this.type});

  @override
  List<Object?> get props => [idProduct, quantity, checked, type];
}
