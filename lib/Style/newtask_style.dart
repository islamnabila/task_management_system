

import 'package:flutter/material.dart';
import 'package:task_manager_practice/Screen/add_newtask_screen.dart';
import 'package:task_manager_practice/Screen/edit-profile_screen.dart';
import 'package:task_manager_practice/Style/style.dart';

import '../widget/newtask_card_item.dart';
import '../widget/newtask_reuseablecard.dart';
import '../widget/profilelisttile_style_screen.dart';

//Upper ListTyle style
ProfileListTileStyle ListTyleStyle(){
  return ProfileListTileStyle();
}



//Card Style horizontal
SingleChildScrollView newtaskCardStyle(){
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: const EdgeInsets.only(left: 16,right: 16),
      child: Row(
        children: [
          ReuseableCard(count: '9', title: 'New Task',),
          ReuseableCard(count: '9', title: 'In Progress',),
          ReuseableCard(count: '9', title: 'Completed',),
          ReuseableCard(count: '9', title: 'Cancelled',),
        ],
      ),
    ),
  );
}


//Card Style Vertical
Expanded newtaskCardStyleVertical(){
  return Expanded(
      child: ListView.builder(
        itemCount: 5,
          itemBuilder: (context, index){
        return NewtaskCardItem();
      })
  );
}

