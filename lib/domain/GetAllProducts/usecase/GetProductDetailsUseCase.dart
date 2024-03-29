import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stc_health_suits/data/repositories/products_repository/ProductsRepository.dart';
import '../../../../common/custom_functions.dart';
import '../../../../core/use_case.dart';
import '../../../../data/exceptions/ErrorResponse.dart';
import '../../../../data/remote/dio/data_state.dart';
import '../model/ProductDetailsModel.dart';

class GetProductDetailsUseCase implements UseCase<DataState<ProductDetailsModel>, GetProductDetailsParams>{
  final ProductsRepository _productsRepository;

  GetProductDetailsUseCase(this._productsRepository);

  ProductDetailsModel? get dto => null;

  @override
  Future<DataState<ProductDetailsModel>> call(
      {required GetProductDetailsParams params}) async {
    try {
      final httpResponse = await _productsRepository.getProductDetails(params);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (kDebugMode) debugPrint("Successfully get response");
        return DataSuccess(
            ProductDetailsModel.fromJson(httpResponse.data.toJson()));
      }
      return DataFailed(ErrorResponse(message: '${httpResponse.response.statusMessage}' , statusCode: httpResponse.response.statusCode));
    } on DioException catch (e) {
      // final errorMessage = DioException.fromDioError(e).toString();
      if (kDebugMode) {
        // debugPrint("fail :$errorMessage");
        debugPrint("Error in Getting Data");
      }
      // return DataFailed(hCheckExceptionType(e));
      return DataFailed(ErrorResponse(message: '${e.response?.statusMessage}' , statusCode: e.response?.statusCode));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return DataFailed(ErrorResponse(message: e.toString(), statusCode: 0));
    }
  }
}

class GetProductDetailsParams{
  final int productId;

  GetProductDetailsParams(this.productId);
}