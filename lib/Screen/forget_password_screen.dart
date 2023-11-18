import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_practice/Screen/login_screen.dart';
import 'package:task_manager_practice/Screen/pin_verification_screen.dart';
import 'package:task_manager_practice/Screen/signup_screen.dart';
import '../Style/style.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
                    boldTextStyle("Your Email Address"),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    GreyTextStyle("A 6 digit verification pin will send your emai address"),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    TextFormField(
                      decoration: TextFormFieldWhite("Email"),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    ElevatedButton(
                        style: ElevattedButtonStyle(),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PinVerificationScreen(),));
                        }, child: ButtonChildStyle(Icons.arrow_circle_right_outlined) ),
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
