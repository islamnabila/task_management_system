import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_practice/Rest%20Api/network_response_class.dart';
import 'package:task_manager_practice/Rest%20Api/rest_api.dart';
import 'package:task_manager_practice/controller/auth_controller.dart';
import 'package:task_manager_practice/model/user_model.dart';
import '../Style/style.dart';
import '../Utility/url.dart';



class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _updateProfileInProgress = false;

  XFile? photo;

  @override
  void initState() {
    super.initState();
    _emailController.text = AuthController.user?.email ?? "";
    _fNameController.text = AuthController.user?.firstName ?? "";
    _lNameController.text = AuthController.user?.lastName ?? "";
    _mobileController.text = AuthController.user?.mobile ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTyleStyle(),
            Expanded(
              child: Stack(
                children: [
                  ScreenBackGround(context),
                  SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              boldTextStyle("Update Profile"),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              PhotoContainerStyle(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              TextFormField(
                                  controller: _emailController,
                                  decoration: TextFormFieldWhite("Email"),
                                  validator: (String? value) {
                                    if (value?.trim().isEmpty ?? true) {
                                      return " Enter your valid email";
                                    }
                                    String emailPattern =
                                        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';

                                    RegExp regExp = RegExp(emailPattern);
                                    if (!regExp.hasMatch(value!)) {
                                      return "Enter a valid email address";
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              TextFormField(
                                  controller: _fNameController,
                                  decoration: TextFormFieldWhite("First Name"),
                                  validator: (String? value) {
                                    if (value?.trim().isEmpty ?? true) {
                                      return "Enter your First Name";
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              TextFormField(
                                  controller: _lNameController,
                                  decoration: TextFormFieldWhite("Last Name"),
                                  validator: (String? value) {
                                    if (value?.trim().isEmpty ?? true) {
                                      return " Enter your last name";
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              TextFormField(
                                  controller: _mobileController,
                                  decoration: TextFormFieldWhite("Mobile"),
                                  validator: (String? value) {
                                    if (value?.trim().isEmpty ?? true) {
                                      return null;
                                    }
                                    if (value!.trim().length != 11) {
                                      return "Mobile number must be 11 digits";
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              TextFormField(
                                controller: _passController,
                                decoration:
                                    TextFormFieldWhite("Password (optional)"),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Visibility(
                                visible: _updateProfileInProgress == false,
                                replacement: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                child: ElevatedButton(
                                    style: ElevattedButtonStyle(),
                                    onPressed: updateProfile,
                                    child: ButtonChildStyle(
                                        Icons.arrow_circle_right_outlined)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    String? photoInBased64;
    Map<String, dynamic> inputDate = {
      "email": _emailController.text.trim(),
      "firstName": _fNameController.text.trim(),
      "lastName": _lNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };

    if (_passController.text.isNotEmpty) {
      inputDate["password"] = _passController.text;
    }

    if(photo != null){
      List<int> imageByte = await photo!.readAsBytes();
      photoInBased64 = base64Encode(imageByte);
      inputDate['photo'] =photoInBased64;
    }



    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, body: inputDate);
    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      AuthController.updateUserInformation(UserModel(
          email: _emailController.text.trim(),
          firstName: _fNameController.text.trim(),
          lastName: _lNameController.text.trim(),
          mobile: _mobileController.text.trim(),
          photo: photoInBased64 ?? AuthController.user?.photo
      ));
      if (mounted) {
        showSnackMessage(context, "Update Profile Successfully!");
      }
    } else {
      if (mounted) {
        showSnackMessage(context, "Update Profile failed! Try Again.");
      }
    }
  }

  Container PhotoContainerStyle(){
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6)
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(6), bottomLeft: Radius.circular(6))
                ),
                alignment: Alignment.center,
                child: const Text("Photo", style: TextStyle(color: colorWhite,fontSize: 17),),
              )),
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: () async {
                  final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50);
                  if(image != null){
                    photo =image;
                    if(mounted){
                      setState(() {});
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  decoration: const BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(6),bottomRight: Radius.circular(6)),
                  ),
                  child: Visibility(
                    visible: photo == null,
                      replacement:Text(photo?.name ?? "") ,
                      child: const Text("Select a photo", style: TextStyle(fontSize: 17),)),
                ),
              ))
        ],
      ),
    );
  }
}
