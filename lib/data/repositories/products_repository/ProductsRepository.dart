import 'package:retrofit/dio.dart';
import 'package:stc_health_suits/data/models/GetAllProductsResponse.dart';
import 'package:stc_health_suits/data/remote/services/translation/products_service.dart';
import '../../../domain/GetAllProducts/usecase/GetAllProductsUseCase.dart';
import '../../../domain/GetAllProducts/usecase/GetProductDetailsUseCase.dart';
import '../../models/ProductDetailsResponse.dart';


class ProductsRepository{

  final ProductsService _productsService;

  ProductsRepository(this._productsService);

  Future<HttpResponse<GetAllProductsListResponse>> getAllProducts(GetAllProductsParams params) =>
      _productsService.hGetAllProducts();

  Future<HttpResponse<ProductDetailsResponse>> getProductDetails(GetProductDetailsParams params) =>
      _productsService.hGetProductDetails(params.productId);

}