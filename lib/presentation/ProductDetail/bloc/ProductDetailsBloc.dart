import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/di/injector.dart';
import '../../../domain/GetAllProducts/usecase/GetProductDetailsUseCase.dart';
import 'ProductDetailsEvent.dart';
import 'ProductDetailsState.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    final GetProductDetailsUseCase getProductDetailsUseCase = injector<GetProductDetailsUseCase>();

    on<GetProductDetails>((event, emit) async {
      try {
        emit(ProductDetailsLoading());
        final httpResponse = await getProductDetailsUseCase.call(
            params: GetProductDetailsParams(event.id));
        emit(ProductDetailsLoaded(httpResponse.data!));
        if (httpResponse.error != null) {
          emit(ProductDetailsError(httpResponse.error?.message));
        }
      } catch(e) {
        emit(const ProductDetailsError("Failed to fetch data. is your device online?"));
      }
    });
  }
}