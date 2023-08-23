import 'package:equatable/equatable.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/ProductDetailsModel.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductDetailsModel productDetailsModel;
  const ProductDetailsLoaded(this.productDetailsModel);
}

class ProductDetailsError extends ProductDetailsState {
  final String? message;
  const ProductDetailsError(this.message);
}