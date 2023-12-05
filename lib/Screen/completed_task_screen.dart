import 'package:flutter/material.dart';
import 'package:task_manager_practice/Rest%20Api/network_response_class.dart';
import 'package:task_manager_practice/Rest%20Api/rest_api.dart';
import 'package:task_manager_practice/model/task_list_model.dart';

import '../Style/style.dart';
import '../Utility/url.dart';
import '../widget/newtask_card_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  void onTaskStatusChange() {
    getCompletedTaskList();
  }
  bool getCompletedTaskInProgress= false;

  TaskListModel taskListModel =TaskListModel();
  Future<void> getCompletedTaskList()async{
    getCompletedTaskInProgress = true;
    if(mounted){
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest((Urls.getCompletedTask));
    if(response.isSuccess){
      taskListModel =TaskListModel.fromJson(response.jsonResponse);
    }
    getCompletedTaskInProgress = false;
    if(mounted){
      setState(() {
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getCompletedTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child: Column(
            children: [
              ListTyleStyle(),
              Expanded(
                  child: Visibility(
                    visible: getCompletedTaskInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () async{
                        getCompletedTaskList();
                      },
                      child: ListView.builder(
                          itemCount: taskListModel.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return NewtaskCardItem(
                                task: taskListModel.taskList![index],
                                onStatusChange: () {
                              getCompletedTaskList();
                            },
                                onTaskStatusChange: onTaskStatusChange,
                                showProgress: (inProgress){
                                  getCompletedTaskInProgress = inProgress;
                                  if(mounted){
                                    setState(() {

                                    });
                                  }
                                }
                            );
                          }),
                    ),
                  )),
            ],
          ))
    );
  }
}
