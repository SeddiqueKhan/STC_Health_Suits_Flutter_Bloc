import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stc_health_suits/data/remote/services/translation/products_service.dart';
import 'package:stc_health_suits/data/repositories/products_repository/ProductsRepository.dart';
import 'package:stc_health_suits/domain/GetAllProducts/usecase/GetAllProductsUseCase.dart';
import 'package:stc_health_suits/domain/GetAllProducts/usecase/GetProductDetailsUseCase.dart';
import '../../common/constants.dart';
import '../../data/remote/dio/dio_factory.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {

  // Dio client
  injector.registerSingleton<Dio>(DioFactory(rBaseUrl).create());

  // Data - Remote
  injector.registerSingleton<ProductsService>(ProductsService(injector()));

  // Data - Repository
  injector.registerSingleton<ProductsRepository>(ProductsRepository(injector()));

  // Domain
  injector.registerSingleton<GetAllProductsUseCase>(GetAllProductsUseCase(injector()));
  injector.registerSingleton<GetProductDetailsUseCase>(GetProductDetailsUseCase(injector()));

}
