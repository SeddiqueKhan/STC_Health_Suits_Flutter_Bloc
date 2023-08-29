import 'package:equatable/equatable.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/GetAllProductsModel.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/ProductDetailsModel.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
}

class ProfileError extends ProfileState {
  final String? message;
  const ProfileError(this.message);
}