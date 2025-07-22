import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:pgcard/models/login/login_response.dart';

part 'login_api.g.dart';

@RestApi(baseUrl: "https://554e-2001-448a-404e-6f07-117f-3561-f8de-3f01.ngrok-free.app")
abstract class LoginApi {
  factory LoginApi(Dio dio, {String baseUrl}) = _LoginApi;

  @POST("/login")
  Future<LoginResponse> login(
    @Field("rm") String rm,
    @Field("password") String password,
  );
}
