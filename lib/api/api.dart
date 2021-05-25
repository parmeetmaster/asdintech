import 'package:asdintech/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  static Dio? dio;

  getInstance() {
    if (dio == null) {
      initialize();
    }
    return dio;
  }

  void initialize() {
    dio = Dio(BaseOptions())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
           requestBody: true,
          responseBody: true,
          responseHeader: true,
          request: true,
          error: true,
          compact: true,
          maxWidth: 90));
  }
}

class ApiBase {
  uplaodImage(String userid, String type, String base64) async {
    Response response = await Api()
        .getInstance()
        .post("https://asdintech.com/webapi/InsertSql/saveImageData",
            data: FormData.fromMap({
              "case_id": userid,
              "type": type,
              "image_base64_string": base64,
            }));
  }

  getUserData(String id) async {
Dio dio1= await Api()
        .getInstance();
dio1.options.headers['content-Type'] = 'application/json';
      Response response=await  dio1.get("https://asdintech.com/webapi/api/android/$id");

    return UserModel.fromJson(response.data[0]);
  }
}
