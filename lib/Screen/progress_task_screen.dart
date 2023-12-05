import 'package:flutter/material.dart';
import '../Rest Api/network_response_class.dart';
import '../Rest Api/rest_api.dart';
import '../Style/style.dart';
import '../Utility/url.dart';
import '../model/task_list_model.dart';
import '../widget/newtask_card_item.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  void onTaskStatusChange() {
    getProgressTaskList();
  }
  bool getProgressTaskInProgress = false;


  TaskListModel taskListModel = TaskListModel();


  Future<void> getProgressTaskList() async {
    getProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getProgressTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

 @override
  void initState() {
    super.initState();
    getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ListTyleStyle(),
            Expanded(
              child: Visibility(
                visible: getProgressTaskInProgress == false,
                replacement:const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: getProgressTaskList,
                  child: ListView.builder(
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return NewtaskCardItem(
                            task: taskListModel.taskList![index], onStatusChange: () {
                          getProgressTaskList();
                        },
                            onTaskStatusChange: onTaskStatusChange,
                            showProgress: (inProgress){
                              getProgressTaskInProgress = inProgress;
                              if(mounted){
                                setState(() {

                                });
                              }
                            }
                        );
                      }),
                ),
              ),
            ),

            ],
          ),
        )
    );
  }
}


