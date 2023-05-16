import 'package:dio/dio.dart';
import 'package:otp_code/models/data_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class OtpApi {
  Future<DataModel> getOtp() async{
    final dio = Dio();
    dio
      ..options.baseUrl = "https://otp-request.onrender.com"
      ..options.responseType = ResponseType.json;
    dio.interceptors.add(PrettyDioLogger());
    try{
      final response = await dio.get('/get-otp');
      return DataModel.fromJson(response.data);
    }
    catch(e){
      throw e;
    }
  }
}
