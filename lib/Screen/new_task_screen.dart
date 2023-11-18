import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Style/newtask_style.dart';
import '../Style/style.dart';
import 'add_newtask_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorGreen,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTaskScreen(),),);
        },
        child: Icon(Icons.add),),

      body: SafeArea(
        child: Column(
          children: [
            ListTyleStyle(),
            newtaskCardStyle(),
            newtaskCardStyleVertical()
          ],
        ),
      )
    );
  }
}
