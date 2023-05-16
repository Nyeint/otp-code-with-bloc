import 'dart:async';
import 'package:otp_code/api/otp_api.dart';
import 'package:otp_code/models/data_model.dart';

class OtpRepository {
  final OtpApi _otpApi;
  OtpRepository(this._otpApi);

  Future<DataModel> getOtp() async{
    return _otpApi.getOtp();
  }
}