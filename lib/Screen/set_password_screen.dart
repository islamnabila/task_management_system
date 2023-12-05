import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_practice/Screen/login_screen.dart';
import '../Rest Api/rest_api.dart';
import '../Style/style.dart';
import '../Utility/url.dart';
import '../Utility/utility.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  Future<bool> setPasswordRequest(Map<String, String> formValues) async {
    try {
      final response = await NetworkCaller().postRequest(
        Urls.recoverResetPass,
        body: formValues,
      );
      if (response.statusCode == 200 &&
          response.jsonResponse['status'] == "success") {
        if (mounted) {
          showSnackMessage(context, "Request Success");
        }
        return true;
      } else {
        if (mounted) {
          showSnackMessage(context, "Request failed!");
        }
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Map<String, String> FormValues = {
    "email": "",
    "OTP": "",
    "password": "",
    "cpassword": ""
  };
  bool Loading = false;

  @override
  initState() {
    callStoreData();
    super.initState();
  }

  callStoreData() async {
    String? OTP = await ReadUserData("OTPVerification");
    String? Email = await ReadUserData("EmailVerification");
    InputOnChange("email", Email);
    InputOnChange("OTP", OTP);
  }

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async {
    if (FormValues['password']!.length == 0) {
      showSnackMessage(context, "Password required!");
    }
    else if (FormValues['password'] != FormValues['cpassword']) {
      showSnackMessage(context, "Confirm password should be same!");
    } else {
      setState(() {
        Loading = true;
      });
      bool res = await setPasswordRequest(FormValues);
      if (res == true) {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        }
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
                    boldTextStyle("Set Password"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    GreyTextStyle(
                        "Minimum length password 8 character with letter and number cobination"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      onChanged: (Textvalue) {
                        InputOnChange("password", Textvalue);
                      },
                      decoration: TextFormFieldWhite("Password"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      onChanged: (Textvalue) {
                        InputOnChange("cpassword", Textvalue);
                      },
                      obscureText: true,
                      decoration: TextFormFieldWhite("Confirm Password"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    ElevatedButton(
                        style: ElevattedButtonStyle(),
                        onPressed: () {
                          FormOnSubmit();
                        },
                        child: ButtonChildStyleText("Confirm")),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0,
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
                                    builder: (context) => const LoginScreen(),
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
