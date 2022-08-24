import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/ui/pages/add_task_page.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/button.dart';
import 'package:todo_app/ui/widgets/task_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  final TaskController controller = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    controller.getTask();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
        init: TaskController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              actions: const [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('images/person.jpeg')),
                ),
                SizedBox(
                  width: 12,
                )
              ],
              leading: IconButton(
                icon: Icon(
                  Get.isDarkMode ? Icons.sunny : Icons.nightlight,
                  color: primaryClr,
                ),
                onPressed: () {
                  Get.isDarkMode
                      ? Get.changeThemeMode(ThemeMode.light)
                      : Get.changeThemeMode(ThemeMode.dark);
                },
              ),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: Column(
              children: [
                taskBar(),
                dateBar(),
                if (controller.taskList.isEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 220,
                        width: 220,
                        child: SvgPicture.asset('images/task.svg',
                            semanticsLabel: 'Acme Logo'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'you dont have any tasks ',
                        style: title1,
                      ),
                    ],
                  )
                else
                  showTask(),
              ],
            ),
          );
        });
  }

  taskBar() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat().add_yMMMMd().format(DateTime.now()),
                style: title1.copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                'Today',
                style: title1,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
                label: '+Add Task',
                onTap: () {
                  Get.to(const AddTaskPage());
                }),
          ),
        ],
      ),
    );
  }

  dateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        monthTextStyle: GoogleFonts.lato(
            color: Colors.grey,
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        dayTextStyle: GoogleFonts.lato(
            color: Colors.grey,
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        dateTextStyle: GoogleFonts.lato(
            color: Colors.grey,
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        width: 70,
        height: 100,
        selectedTextColor: Colors.white,
        deactivatedColor: Colors.grey,
        selectionColor: primaryClr,
        onDateChange: (newDate) {
          setState(() {
            now = newDate;
          });
        },
      ),
    );
  }

  showTask() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          Task task = controller.taskList[index];
          return task.date == DateFormat.yMd().format(now) ||
                  task.repeat == 'Daily'
              ? AnimationConfiguration.staggeredList(
                  duration: const Duration(milliseconds: 1333),
                  position: index,
                  child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          showBottomSheet(context, task);
                        },
                        child: TaskTile(
                          task: task,
                        ),
                      ),
                    ),
                  ),
                )
              : Container();
        },
        itemCount: controller.taskList.length,
      ),
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    return Get.bottomSheet(
      Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode
                ? darkGreyClr.withOpacity(0.5)
                : Colors.transparent,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                task.isCompleted == 1
                    ? Container()
                    : buildBottomSheet(() {
                        controller.markCompleted(task.id);
                      }, 'Task Completed'),
                buildBottomSheet(() {
                  Get.back();
                  controller.deleteOneTask(task.id);
                }, 'Delete Task'),
                buildBottomSheet(() {
                  Get.back();
                }, 'Cancel')
              ],
            ),
          )),
    );
  }

  buildBottomSheet(onTap, label) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
      width: double.infinity,
      child: MaterialButton(
        onPressed: onTap,
        color: primaryClr,
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          label,
          style: title1,
        ),
      ),
    );
  }
}
