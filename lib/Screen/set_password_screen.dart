
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_practice/Screen/login_screen.dart';
import 'package:task_manager_practice/Screen/pin_verification_screen.dart';
import 'package:task_manager_practice/Screen/signup_screen.dart';

import '../Style/style.dart';
import 'forget_password_screen.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
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
                    boldTextStyle("Set Password"),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    GreyTextStyle("Minimum length password 8 character with letter and number cobination"),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    TextFormField(
                      decoration: TextFormFieldWhite("Email"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    TextFormField(
                      obscureText: true,
                      decoration: TextFormFieldWhite("Confirm Password"),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    ElevatedButton(
                        style: ElevattedButtonStyle(),
                        onPressed: (){
                        }, child: ButtonChildStyleText("Confirm") ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.0,),
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
