import 'package:dio/dio.dart';
import 'package:otp_code/models/data_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class OtpApi {
  // dio instance
  // final DioClient _dioClient;
 // OtpApi(this._dioClient);

  Future<DataModel> getOtp() async{
    final dio = Dio();
    dio
      ..options.baseUrl = "https://otp-request.onrender.com"
      ..options.responseType = ResponseType.json;
      // ..options.followRedirects = false
      // ..options.headers = {'Content-Type': 'application/json'}
      // ..options.headers = {'X-API-Key': '{{ x-api-key }}'}
      // ..options.headers = {'Locale': 'en'}
      // ..options.headers['Accept'] = 'application/json';
    dio.interceptors.add(PrettyDioLogger());
    try{
      final response = await dio.get('/get-otp');
      print("HHHYYYY");
      return DataModel.fromJson(response.data);
      return response.data;
    }
    catch(e){
      throw e;
    }
  }
}
