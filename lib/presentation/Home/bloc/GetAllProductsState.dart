import 'package:equatable/equatable.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/GetAllProductsModel.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/ProductDetailsModel.dart';

abstract class GetAllProductsState extends Equatable {
  const GetAllProductsState();

  @override
  List<Object?> get props => [];
}

class GetAllProductsInitial extends GetAllProductsState {}

class GetAllProductsLoading extends GetAllProductsState {}

class GetAllProductsLoaded extends GetAllProductsState {
  final GetAllProductsModel getAllProductsListModel;
  const GetAllProductsLoaded(this.getAllProductsListModel);
}

class GetAllProductsError extends GetAllProductsState {
  final String? message;
  const GetAllProductsError(this.message);
}