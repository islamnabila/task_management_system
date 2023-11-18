import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Style/newtask_style.dart';
import '../Style/style.dart';
import 'main_bottom_navbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                            boldTextStyle("Update Profile"),
                            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                            PhotoContainerStyle(),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            TextFormField(
                              decoration: TextFormFieldWhite("Email"),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            TextFormField(
                              decoration: TextFormFieldWhite("First Name"),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            TextFormField(
                              decoration: TextFormFieldWhite("Last Name"),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            TextFormField(
                              decoration: TextFormFieldWhite("Mobile"),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                            TextFormField(
                              decoration: TextFormFieldWhite("Password"),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                            ElevatedButton(
                                style: ElevattedButtonStyle(),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MainBottomNavScreen(),),);
                                }, child: ButtonChildStyle(Icons.arrow_circle_right_outlined) ),
                          ],
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
}
