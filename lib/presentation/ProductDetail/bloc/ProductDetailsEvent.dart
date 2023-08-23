import 'package:equatable/equatable.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetProductDetails extends ProductDetailsEvent {
  final int id;
  const GetProductDetails({required this.id});
}