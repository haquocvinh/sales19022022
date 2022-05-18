import 'package:equatable/equatable.dart';

abstract class LogInEventBase extends Equatable {}

// ignore: must_be_immutable
class LoginEvent extends LogInEventBase {
  late String phone;
  late String password;

  LoginEvent({required this.phone, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [phone, password];
}
