import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:otp_code/bloc/otp_event.dart';
import 'package:otp_code/bloc/otp_state.dart';
import 'package:otp_code/models/data_model.dart';
import 'package:otp_code/repository/otp_respository.dart';

class OtpBloc extends Bloc<OtpEvent,OtpState>{
  OtpRepository otpRepository;
  OtpBloc(this.otpRepository) : super(OtpInitialized());

  @override
  Stream<OtpState> mapEventToState(
      OtpEvent event
      ) async*{
    if(event is FetchOtp){
      yield OtpLoading();
      bool result = await InternetConnectionChecker().hasConnection;
      if(result == true){
        try{
          DataModel dataModel=await otpRepository.getOtp();
          yield OtpSuccess(dataModel: dataModel);
        }
        catch (e){
          yield OtpError(errorMessage: "Failed. There is something wrong.");
        }
      }
      else{
        yield OtpError(errorMessage: "No internet connection");
      }
    }
  }
}