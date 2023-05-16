import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class FillOtpView extends StatefulWidget {
  String otpCode;
  FillOtpView({Key? key, required this.otpCode}) : super(key: key);

  @override
  State<FillOtpView> createState() => _FillOtpViewState();
}

class _FillOtpViewState extends State<FillOtpView> {
  int isCorrectOtp=2;
  ValueNotifier<bool> keyboardVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return
      Wrap(
        children: [
          Text('OTP ကုဒ်နံပါတ်အားဖြည့်ပါ',
            style: TextStyle(fontWeight: FontWeight.bold),),
          Text('တစ်ခါသုံးကုဒ်ဖြစ်သောကြောင့် ၁ မိနစ်အတွင်းထည့်သွင်းပါ',),
          Padding(padding: EdgeInsets.only(top: 40)),
          PinCodeTextField(
            appContext: context,
            length: 6,
            blinkWhenObscuring: true,
            enablePinAutofill: false,
            pinTheme: PinTheme(
                activeColor: isCorrectOtp==0?Colors.green:
                isCorrectOtp==1?Colors.red:Colors.black,
                inactiveColor: Colors.black,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 50,
                selectedFillColor:Colors.white,
                selectedColor: Colors.black
            ),
            cursorColor: Colors.black,
            autoFocus: true,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if(value.length<6){
                setState(() {
                  isCorrectOtp=2;
                });
              }
              else if(value==widget.otpCode){
                setState(() {
                  isCorrectOtp=0;
                });
              }
              else{
                setState(() {
                  isCorrectOtp=1;
                });
              }
            },
            beforeTextPaste: (text) {
              return true;
            },
          ),
          ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff0C1553),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
              ),
              child:
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: Center(child: Text('အတည်ပြုမည်')))
          ),
          Padding(padding: EdgeInsets.only(top: 60)),
        ],
      );
  }
}