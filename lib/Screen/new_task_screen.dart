import 'package:flutter/material.dart';
import 'package:task_manager_practice/Rest%20Api/network_response_class.dart';
import 'package:task_manager_practice/Rest%20Api/rest_api.dart';
import 'package:task_manager_practice/model/task_count_summary_model.dart';
import 'package:task_manager_practice/model/task_list_model.dart';

import '../Style/newtask_style.dart';
import '../Style/style.dart';
import '../Utility/url.dart';
import '../model/task_count.dart';
import '../widget/newtask_card_item.dart';
import '../widget/newtask_reuseablecard.dart';
import 'add_newtask_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});



  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

//immediately add task without refreshing
typedef TaskCreatedCallback = void Function();

class _NewTaskScreenState extends State<NewTaskScreen> {

  //method for changing number immediately when task updated from one category to another
  void onTaskStatusChange() {
    getNewTaskList();
    getTaskCountSummaryList();
  }

bool getNewTaskInProgress = false;
  bool getTaskCountSummaryListInProgress = false;

  TaskListModel taskListModel = TaskListModel();
  TaskCountSummaryModel taskCountSummaryModel = TaskCountSummaryModel();

  Future<void> getNewTaskList() async {
    getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getNewTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }



  Future<void> getTaskCountSummaryList() async {
    getTaskCountSummaryListInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskCountSummaryModel =
          TaskCountSummaryModel.fromJson(response.jsonResponse);
    }
    getTaskCountSummaryListInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getNewTaskList();
    getTaskCountSummaryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorGreen,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewTaskScreen(
                  onTaskCreated: () {
                    getNewTaskList();
                  },

                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ListTyleStyle(),
              Visibility(
                visible: getTaskCountSummaryListInProgress == false && (taskCountSummaryModel.taskCountList?.isNotEmpty ?? false),
                replacement: const LinearProgressIndicator(),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: taskCountSummaryModel.taskCountList?.length ?? 0,
                      itemBuilder: (context, index) {
                      TaskCount taskCount = taskCountSummaryModel.taskCountList![index];
                    return FittedBox(
                        child: ReuseableCard(
                            count: taskCount.sum.toString(),
                            title: taskCount.sId ?? ""));
                  }),
                ),
              ),
              Expanded(
                  child: Visibility(
                visible: getNewTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: () async{
                    getNewTaskList();
                  },
                  child: ListView.builder(
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return NewtaskCardItem(
                          task: taskListModel.taskList![index],
                            onStatusChange: () {
                            getNewTaskList();
                            },
                            onTaskStatusChange: onTaskStatusChange,
                          showProgress: (inProgress){
                            getNewTaskInProgress = inProgress;
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
          ),
        ));
  }
}
