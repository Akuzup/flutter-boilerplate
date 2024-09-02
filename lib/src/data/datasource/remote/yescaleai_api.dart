import 'package:app_core/app_core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/providers/yescaleai_network_provider.dart';

part 'yescaleai_api.g.dart';

class YescaleaiApiConstants {
  static const completions = 'chat/completions';
}

@RestApi()
@injectable
abstract class YescaleaiApi {
  @factoryMethod
  factory YescaleaiApi(YescaleaiNetworkProvider provider) =>
      _YescaleaiApi(provider.dio);

  @POST(YescaleaiApiConstants.completions)
  Future<ApiResponse<dynamic>> sendCompletions({
    @Body() required Map<String, dynamic> payload,
  });

  @POST(YescaleaiApiConstants.completions)
  Future<ApiResponse<dynamic>> addToCart({
    @Path('productId') required int productId,
  });
}
