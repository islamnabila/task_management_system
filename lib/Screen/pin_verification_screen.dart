import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_practice/Screen/login_screen.dart';
import 'package:task_manager_practice/Screen/set_password_screen.dart';
import 'package:task_manager_practice/Screen/signup_screen.dart';
import 'package:http/http.dart' as http;


import '../Rest Api/api_client.dart';
import '../Style/style.dart';
import '../Utility/utility.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});



  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {


  Future<bool> VerifyOTPRequest(Email,OTP) async{
    var URL=Uri.parse("${BaseURL}/RecoverVerifyOTP/${Email}/${OTP}");
    var response= await  http.get(URL,headers:RequestHeader);
    var ResultCode=response.statusCode;
    var ResultBody=json.decode(response.body);
    if(ResultCode==200 && ResultBody['status']=="success"){
      await WriteOTPVerification(OTP);
      print("Success");

      return true;
    }
    else{
      print("fail");
      return false;
    }
  }

  Map<String,String> FormValues={"otp":""};
  bool Loading=false;

  InputOnChange(MapKey, Textvalue){
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async{
    if(FormValues['otp']!.length!=6){
    }
    else{
      setState(() {Loading=true;});
      String? emailAddress=await ReadUserData('EmailVerification');
      bool res=await VerifyOTPRequest(emailAddress,FormValues['otp']);
      if(res==true){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SetPasswordScreen()));
      }
      else{
        setState(() {Loading=false;});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackGround(context),
          Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                    boldTextStyle("Pin Verification"),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    GreyTextStyle("A 6 digit verification pin will send your emai address"),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    PinCodeTextField(

                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        activeColor: colorGreen,
                        selectedFillColor: colorWhite,
                        inactiveFillColor: colorWhite,
                        inactiveColor: colorGreen
                      ),
                      animationDuration: Duration(milliseconds: 300),

                      enableActiveFill: true,
                      onCompleted: (v) {
                        print("Completed");
                      },
                        onChanged: (value) {
                          InputOnChange("otp",value);
                        },
                      beforeTextPaste: (text) {
                        return true;
                      }, appContext: context,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    ElevatedButton(
                        style: ElevattedButtonStyle(),
                        onPressed: (){
                          FormOnSubmit();
                        }, child: ButtonChildStyleText("Verify") ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.07,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BoldSmallTextStyle("Have account?"),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(),));
                        }, child:TextButtonChildStyle("Sign In"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
