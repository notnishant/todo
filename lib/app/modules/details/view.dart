import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo2/app/core/utils/extensions.dart';
import 'package:todo2/app/modules/home/controller.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(3.0.wp),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                    homeCtrl.changeTask(null);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.0.wp,
          ),
          child: Row(children: [
            Icon(
              IconData(
                task.icon,
                fontFamily: 'MaterialIcons',
              ),
              color: color,
            ),
            SizedBox(width: 3.0.wp),
            Text(
              task.title,
              style: TextStyle(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
      ],
    ));
  }
}
