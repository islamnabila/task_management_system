import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Style/newtask_style.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child: Column(
            children: [
              ListTyleStyle(),
              newtaskCardStyleVertical()
            ],
          ))
    );
  }
}
