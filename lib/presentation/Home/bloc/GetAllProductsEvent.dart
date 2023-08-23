import 'package:equatable/equatable.dart';

abstract class GetAllProductsEvent extends Equatable {
  const GetAllProductsEvent();

  @override
  List<Object> get props => [];
}

class GetAllProducts extends GetAllProductsEvent {}