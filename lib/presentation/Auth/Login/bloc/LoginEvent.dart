import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  final String phone;
  final String password;

  const Login({required this.phone, required this.password});
}