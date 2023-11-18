import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_practice/Screen/login_screen.dart';
import 'package:task_manager_practice/Screen/set_password_screen.dart';
import 'package:task_manager_practice/Screen/signup_screen.dart';


import '../Style/style.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
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
                       
                      },
                      beforeTextPaste: (text) {
                        return true;
                      }, appContext: context,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    ElevatedButton(
                        style: ElevattedButtonStyle(),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SetPasswordScreen(),));
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
