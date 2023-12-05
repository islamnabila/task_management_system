import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_practice/Rest%20Api/network_response_class.dart';
import 'package:task_manager_practice/Rest%20Api/rest_api.dart';

import '../Style/newtask_style.dart';
import '../Style/style.dart';
import '../Utility/url.dart';
import 'new_task_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.onTaskCreated,});
  final TaskCreatedCallback onTaskCreated;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _desController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _createTaskInProgress = false;

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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                              boldTextStyle("Add New Task"),
                              SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                              TextFormField(
                                controller: _subjectController,
                                decoration: TextFormFieldWhite("Subject"),
                                validator: (String? value){
                                  if(value?.trim().isEmpty ?? true){
                                    return "Enter subject";
                                  }
                                  return null;
                                }
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                              TextFormField(
                                controller: _desController,
                                maxLines: 6,
                                decoration: TextFormFieldWhite("Description"),
                                validator: (String? value){
                                  if(value?.trim().isEmpty ?? true){
                                    return "Enter Description";
                                  }
                                  return null;
                                }
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                              Visibility(
                                visible: _createTaskInProgress == false,
                                replacement: Center(child: CircularProgressIndicator(),),
                                child: ElevatedButton(
                                    style: ElevattedButtonStyle(),
                                    onPressed: (){
                                      createTask();
                                      // Navigator.pop(context);
                                    },

                                    child: ButtonChildStyle(Icons.arrow_circle_right_outlined) ),
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

  Future<void> createTask()async{
    if(_formKey.currentState!. validate()){
      _createTaskInProgress = true;
      if(mounted){
        setState(() {});
      }
      final NetworkResponse response = 
          await NetworkCaller().postRequest(Urls.createNewTask, body: {
            "title":_subjectController.text.trim(),
            "description":_desController.text.trim(),
            "status":"New"
          });
      _createTaskInProgress = false;
      if(mounted){
        setState(() {});
      }
      if(response.isSuccess){
        _subjectController.clear();
        _desController.clear();
        if(mounted){
          showSnackMessage(context, "Create task successfully!");
        }
        widget.onTaskCreated.call();

      }else{
        if(mounted){
          showSnackMessage(context, "Create new task failed! Try again.", true);
        }
      }
    }

  }

  @override
  void dispose() {
    _subjectController.dispose();
    _desController.dispose();
    super.dispose();
  }
}
