import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:otp_code/api/otp_api.dart';
import 'package:otp_code/bloc/otp_bloc.dart';
import 'package:otp_code/bloc/otp_event.dart';
import 'package:otp_code/repository/otp_respository.dart';
import 'package:otp_code/utils/aes_decrypt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/otp_state.dart';
import 'fill_otp_view.dart';

class OtpView extends StatefulWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  OtpBloc _otpBloc=OtpBloc(OtpRepository(OtpApi()));
  String? _otpCode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          body:
          BlocProvider<OtpBloc>(
            create: (_)=> OtpBloc(OtpRepository(OtpApi())),
            child: BlocListener<OtpBloc,OtpState>(
              bloc: _otpBloc,
              listener: (context,state){
                if(state is OtpLoading){
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context){
                        return
                          AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Message'),
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    Text('Please Wait')
                                  ],
                                )
                            ),
                          );
                      }
                  );
                }
                else if(state is OtpError){
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:  Text(state.errorMessage),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height - 90,
                        right: 10,
                        left: 10
                    ),
                  )
                  );
                }
                else if(state is OtpSuccess){
                  Navigator.pop(context);
                  final encrypted = encrypt.Encrypted.fromBase64(state.dataModel.code.toString());
                  final decrypted = encrypted.decryptAes(state.dataModel.meta!.secretKey.toString());
                  setState((){
                    _otpCode=decrypted;
                  });
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10,
                                left: 10,right: 10,
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: FillOtpView(otpCode: _otpCode.toString()),
                          );
                      }
                  );
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: ListView(
                      children: [
                        Text('OTP',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        Text(decrypted)
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height*0.38,
                        bottom: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height*0.38+100),
                        right: 10,
                        left: 10
                    ),
                  )
                  );
                }
              },
              child: Center(
                child:
                ElevatedButton(
                  onPressed: (){
                    _otpBloc.add(FetchOtp());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff0C1553),
                  ),
                  child: Text('OTP တောင်းမည်'),
                ),
              ),
            ),
          ),

        )
    );
  }
}