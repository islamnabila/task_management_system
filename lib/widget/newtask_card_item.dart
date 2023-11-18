import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Style/style.dart';

class NewtaskCardItem extends StatelessWidget {
  const NewtaskCardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title will be here!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            Text("Description"),
            Text("Date: 12-11-2023"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text("New", style: TextStyle(color: colorWhite),),backgroundColor: colorGreen,),
                Wrap(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit))

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}