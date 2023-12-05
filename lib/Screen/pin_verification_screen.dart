import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_practice/Screen/login_screen.dart';
import 'package:task_manager_practice/Screen/set_password_screen.dart';
import '../Rest Api/rest_api.dart';
import '../Style/style.dart';
import '../Utility/url.dart';
import '../Utility/utility.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  Future<bool> VerifyOTPRequest(Email, OTP) async {
    final response =
        await NetworkCaller().getRequest(Urls.recoverVerifyOTP(Email, OTP));
    if (response.statusCode == 200 &&
        response.jsonResponse['status'] == "success") {
      await WriteOTPVerification(OTP);
      if (mounted) {
        showSnackMessage(context, "Pin verified successfully!");
      }
      return true;
    } else {
      if (mounted) {
        showSnackMessage(context, "Pin is not correct");
      }
      return false;
    }
  }

  Map<String, String> FormValues = {"otp": ""};
  bool Loading = false;

  InputOnChange(MapKey, Textvalue) {
    setState(() {
      FormValues.update(MapKey, (value) => Textvalue);
    });
  }
  FormOnSubmit() async {
    if (FormValues['otp']!.length != 6) {
    } else {
      setState(() {
        Loading = true;
      });
      String? emailAddress = await ReadUserData('EmailVerification');
      bool res = await VerifyOTPRequest(emailAddress, FormValues['otp']);
      if (res == true) {
        if (mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SetPasswordScreen()));
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
                    boldTextStyle("Pin Verification"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    GreyTextStyle(
                        "A 6 digit verification pin will send your email address"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
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
                          inactiveColor: colorGreen),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        InputOnChange("otp", value);
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    ElevatedButton(
                        style: ElevattedButtonStyle(),
                        onPressed: () {
                          FormOnSubmit();
                        },
                        child: ButtonChildStyleText("Verify")),
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
