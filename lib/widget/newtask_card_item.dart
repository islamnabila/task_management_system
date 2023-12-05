import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_practice/Rest%20Api/rest_api.dart';

import '../Style/style.dart';
import '../Utility/url.dart';
import '../model/task_list.dart';

enum TaskStatus { New, Progress, Completed, Cancelled }

class NewtaskCardItem extends StatefulWidget {
  const NewtaskCardItem({
    super.key,
    required this.task, required this.onStatusChange, required this.showProgress, required this.onTaskStatusChange,
  });

  final Task task;
  final VoidCallback onStatusChange;
  final VoidCallback onTaskStatusChange;
  final Function(bool) showProgress;

  @override
  State<NewtaskCardItem> createState() => _NewtaskCardItemState();
}

class _NewtaskCardItemState extends State<NewtaskCardItem> {

  Future<void> updateTaskStatus(String status)async {
    widget.showProgress(true);
    final response = await NetworkCaller().getRequest(Urls.updateTaskStatus(widget.task.sId ?? "", status));
    if(response.isSuccess){
      widget.onStatusChange();
      widget.onTaskStatusChange();
    }
    widget.showProgress(false);
  }

  Future<void> deleteTask() async{
    widget.showProgress(true);
    final response = await NetworkCaller().getRequest(Urls.deleteTask(widget.task.sId ?? ""));
    if(response.isSuccess){
      widget.onStatusChange();
      widget.onTaskStatusChange();
    }
    widget.showProgress(false);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? "",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(widget.task.description ?? ""),
            Text("Date: ${widget.task.createdDate ?? ""}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? "New",
                    style: TextStyle(color: colorWhite),
                  ),
                  backgroundColor: colorGreen,
                ),
                Wrap(
                  children: [
                    IconButton(onPressed: () {
                      showDeleteStatusModal();
                    }, icon: Icon(Icons.delete)),
                    IconButton(
                        onPressed: () {
                          showUpdateStatusModal();
                        },
                        icon: Icon(Icons.edit))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              title: Text("${e.name}"),
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
            ))
        .toList();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Status"),
            content: Column(mainAxisSize: MainAxisSize.min, children: items),
            actions: [
              ButtonBar(
                children: [
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("Cancel")),

                ],
              )
            ],
          );
        });
  }

  void showDeleteStatusModal() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Status"),
            content: Column(mainAxisSize: MainAxisSize.min,),
            actions: [
              ButtonBar(
                children: [
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("Cancel")),

                ],
              ),
              ButtonBar(
                children: [
                  TextButton(onPressed: () {
                    deleteTask();
                    Navigator.pop(context);
                  }, child: Text("Delete")),

                ],
              )
            ],
          );
        });
  }
}
