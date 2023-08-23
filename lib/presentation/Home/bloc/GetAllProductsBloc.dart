import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/di/injector.dart';
import '../../../domain/GetAllProducts/usecase/GetAllProductsUseCase.dart';
import 'GetAllProductsEvent.dart';
import 'GetAllProductsState.dart';

class GetAllProductsBloc extends Bloc<GetAllProductsEvent, GetAllProductsState> {
  GetAllProductsBloc() : super(GetAllProductsInitial()) {
    final GetAllProductsUseCase getAllProductsUseCase = injector<GetAllProductsUseCase>();

    on<GetAllProducts>((event, emit) async {
      try {
        emit(GetAllProductsLoading());
        final httpResponse = await getAllProductsUseCase.call(
            params: GetAllProductsParams());
        emit(GetAllProductsLoaded(httpResponse.data!));
        if (httpResponse.error != null) {
          emit(GetAllProductsError(httpResponse.error?.message));
        }
      } catch(e) {
        emit(const GetAllProductsError("Failed to fetch data. is your device online?"));
      }
    });
  }
}