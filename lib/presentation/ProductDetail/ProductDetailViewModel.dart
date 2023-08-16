import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../app/di/injector.dart';
import '../../core/view_state.dart';
import '../../data/remote/dio/data_state.dart';
import '../../domain/GetAllProducts/model/ProductDetailsModel.dart';
import '../../domain/GetAllProducts/usecase/GetProductDetailsUseCase.dart';

const loginBusyKey = 'product_detail';


class ProductDetailViewModel extends BaseViewModel{

  final GetProductDetailsUseCase _getProductDetailsUseCase = injector<GetProductDetailsUseCase>();

  ViewState<ProductDetailsModel> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<ProductDetailsModel> viewState) {
    this.viewState = viewState;
    setBusyForObject(loginBusyKey, false);
  }

  Future<void> getProductDetails() async {
    _setViewState(ViewState.loading());
    final httpResponse = await _getProductDetailsUseCase.call(
        params: GetProductDetailsParams(3));
    if (httpResponse is DataSuccess) {
      debugPrint("${httpResponse.data?.price}");
      _setViewState(ViewState.complete(httpResponse.data!));
    }
    if (httpResponse is DataFailed) {
      _setViewState(ViewState.error(httpResponse.error?.message ?? ""));
    }
  }
}