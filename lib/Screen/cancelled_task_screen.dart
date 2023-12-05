import 'package:flutter/material.dart';
import 'package:task_manager_practice/Rest%20Api/network_response_class.dart';
import 'package:task_manager_practice/Rest%20Api/rest_api.dart';
import 'package:task_manager_practice/model/task_list_model.dart';
import '../Style/style.dart';
import '../Utility/url.dart';
import '../widget/newtask_card_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  void onTaskStatusChange() {
    getCancelledTaskList();
  }

  bool getCancelledTaskInprogress= false;
  TaskListModel taskListModel =TaskListModel();
  Future<void> getCancelledTaskList()async{
    getCancelledTaskInprogress = true;
    if(mounted){
      setState(() {

      });
    }
    final NetworkResponse response= await NetworkCaller().getRequest(Urls.getCancelledTask);
    if(response.isSuccess){
      taskListModel =TaskListModel.fromJson(response.jsonResponse);
    }
    getCancelledTaskInprogress =false;
    if(mounted){
      setState(() {

      });
    }
  }
  @override
  void initState() {
    super.initState();
    getCancelledTaskList();

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
                  visible: getCancelledTaskInprogress == false,
                  replacement:const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: getCancelledTaskList,
                    child: ListView.builder(
                        itemCount: taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return NewtaskCardItem(
                              task: taskListModel.taskList![index],
                              onStatusChange: () {
                            getCancelledTaskList();
                          },
                              onTaskStatusChange: onTaskStatusChange,
                              showProgress: (inProgress){
                                getCancelledTaskInprogress = inProgress;
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
          ))
    );
  }
}
