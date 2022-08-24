import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/ui/theme.dart';

class TaskTile extends StatelessWidget {

  const TaskTile({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.isPortrait
          ? const EdgeInsets.all(20)
          : const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: task.color == 0
              ? pinkClr
              : task.color == 1
                  ? bluishClr
                  : orangeClr,
          borderRadius: BorderRadius.circular(16)),
      margin: context.isPortrait
          ? const EdgeInsets.only(left: 20,right: 20,bottom: 5,top: 5)
          : const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title!,
                    style: GoogleFonts.lato(
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
                const SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.access_time_outlined),
                    Text('  ${task.startTime!}-${task.endTime!}',
                        style: GoogleFonts.lato(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  task.note!,
                  style: GoogleFonts.lato(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                )
              ],
            ),
          )),
          Container(
            margin: const EdgeInsets.all(2),
            color: Colors.grey,
            width: 2,
            height: 60,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted == 0 ? 'ToDo' : 'Completed',
              style: GoogleFonts.lato(
                  color: Get.isDarkMode ? Colors.white : Colors.black,fontWeight: FontWeight.bold, fontSize: 18)),
            ),

        ],
      ),
    );
  }
}
