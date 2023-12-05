import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager_practice/Screen/login_screen.dart';
import 'package:task_manager_practice/controller/auth_controller.dart';

import '../Screen/edit-profile_screen.dart';
import '../Style/style.dart';

class ProfileListTileStyle extends StatefulWidget {
  const ProfileListTileStyle({
    super.key,
  });

  @override
  State<ProfileListTileStyle> createState() => _ProfileListTileStyleState();
}

class _ProfileListTileStyleState extends State<ProfileListTileStyle> {
  @override
  Widget build(BuildContext context) {
    // Uint8List imageBytes =
    //     Base64Decoder().convert(AuthController.user?.photo?.trim() ?? "");

    String? photoData = AuthController.user?.photo;
    Uint8List? imageBytes;

    try {
      if (photoData != null && photoData.isNotEmpty) {
        imageBytes = Base64Decoder().convert(photoData.trim());
      }
    } catch (e) {
      print("Error decoding Base64 string: $e");
    }
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ));
      },
      leading: CircleAvatar(
        child: imageBytes != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(50),
            child: Image.memory(imageBytes, fit: BoxFit.cover,))
            : const Icon(Icons.person),
      ),


      title: Text(
        fullname,
        style: const TextStyle(fontSize: 18, color: colorWhite),
      ),
      subtitle: Text(
        AuthController.user?.email ?? "",
        style: TextStyle(color: colorWhite),
      ),
      tileColor: colorGreen,
      trailing: IconButton(
        onPressed: () async {
          await AuthController.ClearAuthData();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          }
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }

  String get fullname {
    return "${AuthController.user?.firstName ?? ""} ${AuthController.user?.lastName ?? ")"}";
  }
}
