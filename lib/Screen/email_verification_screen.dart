import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_practice/Screen/login_screen.dart';
import 'package:task_manager_practice/Screen/pin_verification_screen.dart';

import '../Rest Api/api_client.dart';
import '../Rest Api/rest_api.dart';
import '../Style/style.dart';
import '../Utility/url.dart';
import '../Utility/utility.dart';
import 'package:http/http.dart' as http;

class emailVerificationScreen extends StatefulWidget {
  const emailVerificationScreen({super.key});

  @override
  State<emailVerificationScreen> createState() =>
      _emailVerificationScreenState();
}

class _emailVerificationScreenState extends State<emailVerificationScreen> {
  // Future<bool> recoverVerifyEmail(Email) async {
  //   try {
  //     final response = await NetworkCaller()
  //         .getRequest('${Urls.recoverVerifyEmail}? email=$Email');
  //     print('API Response: ${response.toString()}');
  //     if (response.isSuccess) {
  //       if (response.jsonResponse['status'] == 'success') {
  //         await WriteEmailVerification(Email);
  //
  //       } else {
  //         print('Failed to recover/verify email: ${response.errorMessage}');
  //       }
  //
  //     } else {
  //       print('Failed to recover/verify email: ${response.errorMessage}');
  //     }
  //   } catch (error) {
  //     print('Error during API call: $error');
  //   }
  //   return false;
  // }

  Future<bool> recoverVerifyEmail(Email) async {
    final response =
        await NetworkCaller().getRequest(Urls.recoverVerifyEmail(Email));
    if (response.statusCode == 200 &&
        response.jsonResponse['status'] == "success") {
      await WriteEmailVerification(Email);
      return true;
    } else {
      return false;
    }
  }

  Map<String, String> FormValues = {"email": ""};
  bool Loading = false;

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['email']!.length == 0) {
    } else {
      setState(() {
        Loading = true;
      });
      bool res = await recoverVerifyEmail(FormValues['email']);
      if (res == true) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PinVerificationScreen(),
            ));
      } else {
        setState(() {
          Loading = false;
        });
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    boldTextStyle("Your Email Address"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    GreyTextStyle(
                        "A 6 digit verification pin will send your emai address"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      onChanged: (Textvalue) {
                        InputOnChange("email", Textvalue);
                      },
                      // controller: _emailController,
                      decoration: TextFormFieldWhite("Email"),
                      // validator: (String? value){
                      //   if(value?.trim().isEmpty ?? true){
                      //     return "Enter your email";
                      //   }
                      //   String emailPattern =
                      //       r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
                      //
                      //   RegExp regExp = RegExp(emailPattern);
                      //   if (!regExp.hasMatch(value!)) {
                      //     return "Enter a valid email address";
                      //   }
                      //   return null;
                      // }
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    ElevatedButton(
                        style: ElevattedButtonStyle(),
                        onPressed: FormOnSubmit,
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>PinVerificationScreen()));

                        child: ButtonChildStyle(
                            Icons.arrow_circle_right_outlined)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BoldSmallTextStyle("Have account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));
                            },
                            child: TextButtonChildStyle("Sign In"))
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
