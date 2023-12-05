import 'package:flutter/material.dart';
import 'package:task_manager_practice/Rest%20Api/rest_api.dart';
import 'package:task_manager_practice/Screen/login_screen.dart';

import '../Rest Api/network_response_class.dart';
import '../Style/style.dart';
import '../Utility/url.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _signupInprogress= false;
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
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      boldTextStyle("Join With Us"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: TextFormFieldWhite("Email"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your valid email";
                          }
                          String emailPattern =
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';

                          RegExp regExp = RegExp(emailPattern);
                          if (!regExp.hasMatch(value!)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      TextFormField(
                        controller: _fNameController,
                        decoration: TextFormFieldWhite("First Name"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your first name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      TextFormField(
                        controller: _lNameController,
                        decoration: TextFormFieldWhite("Last Name"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return " Enter your last name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      TextFormField(
                        controller: _mobileController,
                        decoration: TextFormFieldWhite("Mobile"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your mobile number";
                          }
                          if (value!.trim().length != 11) {
                            return "Mobile number must be 11 digits";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      TextFormField(
                        controller: _passController,
                        obscuringCharacter: '*',
                        obscureText: true,
                        decoration: TextFormFieldWhite("Password"),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter your password";
                          }
                          if (value!.length < 6) {
                            return "Password must be more than 6 letters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Visibility(
                        visible: _signupInprogress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            style: ElevattedButtonStyle(),
                            onPressed: _signupOnpressed,

                            child: ButtonChildStyle(
                                Icons.arrow_circle_right_outlined)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoldSmallTextStyle("Have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>const LoginScreen(),
                                    ));
                              },
                              child: TextButtonChildStyle("Sign In"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _signupOnpressed()async {
    if (_formkey.currentState!.validate()) {
      _signupInprogress = true;
      if(mounted){
        setState(() {

        });
      }
      final NetworkResponse response =
      await NetworkCaller()
          .postRequest(Urls.registration, body: {
        "email":_emailController.text.trim(),
        "firstName":_fNameController.text.trim(),
        "lastName":_lNameController.text.trim(),
        "mobile":_mobileController.text.trim(),
        "password":_passController.text,
      });

      _signupInprogress =false;
      if(mounted){
        setState(() {});
      }

      if (response.isSuccess) {
        _clearTextField();
        if (mounted) {
          showSnackMessage(context, "Account has been Created! Please login");
        }
      }else{
        if (mounted) {
          showSnackMessage(context, "Account creation failed! Please try again");
        }
      }
    }
  }

  void _clearTextField(){
    _emailController.clear();
    _fNameController.clear();
    _lNameController.clear();
    _mobileController.clear();
    _passController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fNameController.dispose();
    _lNameController.dispose();
    _mobileController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
