import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stc_health_suits/common/constants.dart';
import 'package:stc_health_suits/data/models/GetAllProductsResponse.dart';
import '../../../../common/api_end_points.dart';
import '../../../models/ProductDetailsResponse.dart';
part 'products_service.g.dart';

@RestApi()
abstract class ProductsService {
  factory ProductsService(Dio dio) = _ProductsService;

  @GET(GET_ALL_PRODUCTS)
  Future<HttpResponse<GetAllProductsResponse>> hGetAllProducts();

  @GET("products/{Id}")
  Future<HttpResponse<ProductDetailsResponse>> hGetProductDetails(
      @Path("Id") int productId,);
}


