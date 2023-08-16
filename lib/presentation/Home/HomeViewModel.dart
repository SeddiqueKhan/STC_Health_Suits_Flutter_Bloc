import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/GetAllProductsModel.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/ProductDetailsModel.dart';
import 'package:stc_health_suits/domain/GetAllProducts/usecase/GetAllProductsUseCase.dart';
import 'package:stc_health_suits/domain/GetAllProducts/usecase/GetProductDetailsUseCase.dart';

import '../../app/di/injector.dart';
import '../../core/view_state.dart';
import '../../data/remote/dio/data_state.dart';

const loginBusyKey = 'home';


class HomeViewModel extends BaseViewModel{

  final GetAllProductsUseCase _getAllProductsUseCase = injector<GetAllProductsUseCase>();


  ViewState<GetAllProductsListModel> viewState =
  ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<GetAllProductsListModel> viewState) {
    this.viewState = viewState;
    setBusyForObject(loginBusyKey, false);
  }


  Future<void> getAllProducts() async {
    _setViewState(ViewState.loading());
    final httpResponse = await _getAllProductsUseCase.call(
        params: GetAllProductsParams());
    if (httpResponse is DataSuccess) {
      debugPrint("the length of products is: ${httpResponse.data?.products.length}");
      _setViewState(ViewState.complete(httpResponse.data!));
    }
    if (httpResponse is DataFailed) {
      _setViewState(ViewState.error(httpResponse.error?.message ?? ""));
    }
  }

}