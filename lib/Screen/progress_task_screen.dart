import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Style/newtask_style.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ListTyleStyle(),
              newtaskCardStyleVertical()
            ],
          ),
        )
    );
  }
}


