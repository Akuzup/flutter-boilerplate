// ignore_for_file: one_member_abstracts

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/providers/chat_network_provider.dart';

part 'chat_api.g.dart';

class ChatApiConstants {
  static const generateContent = '/models/{model}:generateContent';
}

@RestApi()
@injectable
abstract class ChatApi {
  @factoryMethod
  factory ChatApi(ChatNetworkProvider provider) => _ChatApi(provider.dio);

  @POST(ChatApiConstants.generateContent)
  Future<HttpResponse<dynamic>> sendCompletions({
    @Path('model') required String model,
    @Query('key') required String apiKey,
    @Body() required Map<String, dynamic> payload,
  });
}
