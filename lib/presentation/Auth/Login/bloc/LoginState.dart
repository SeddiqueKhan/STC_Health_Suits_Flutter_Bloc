import 'package:equatable/equatable.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/GetAllProductsModel.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/ProductDetailsModel.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
}

class LoginError extends LoginState {
  final String? message;
  const LoginError(this.message);
}