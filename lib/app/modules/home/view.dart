import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo2/app/core/utils/extensions.dart';
import 'package:todo2/app/core/values/colors.dart';
import 'package:todo2/app/data/models/task.dart';
import 'package:todo2/app/modules/home/controller.dart';
import 'package:todo2/app/modules/home/widgets/add_card.dart';
import 'package:todo2/app/modules/home/widgets/add_dialog.dart';
import 'package:todo2/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                'My List',
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.tasks
                      .map((element) => LongPressDraggable(
                            data: element,
                            onDragStarted: () =>
                                controller.changeDeleting(true),
                            onDraggableCanceled: (_, __) =>
                                controller.changeDeleting(false),
                            onDragEnd: (_) => controller.changeDeleting(false),
                            feedback: Opacity(
                              opacity: 0.8,
                              child: TaskCard(
                                task: element,
                              ),
                            ),
                            child: TaskCard(
                              task: element,
                            ),
                          ))
                      .toList(),
                  AddCard()
                ],
              ),
            )
          ],
        )),
        floatingActionButton: DragTarget(
          builder: (_, __, ___) {
            return Obx(
              () => FloatingActionButton(
                backgroundColor: controller.deleting.value ? Colors.red : blue,
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(() => AddDialog(), transition: Transition.downToUp);
                  } else {
                    EasyLoading.showError('Please create task type first');
                  }
                },
                child:
                    Icon(controller.deleting.value ? Icons.delete : Icons.add),
              ),
            );
          },
          onAccept: (Task task) {
            controller.deleteTask(task);
            EasyLoading.showSuccess('Deleted Success');
          },
        ));
  }
}
