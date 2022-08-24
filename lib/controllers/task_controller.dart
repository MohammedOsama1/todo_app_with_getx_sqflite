import 'package:get/get.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/models/task.dart';

class TaskController extends GetxController {
  List taskList = [];

  Future addTask(Task? task) async {
    DBHelper.insert(task);
    getTask();
    update();
  }

  Future getTask() async {
    final List tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((e) => Task.fromJson(e)).toList());
    update();
    print(taskList);
  }

  deleteOneTask(int? id) async {
    await DBHelper.deleteOneTask(id);
    getTask();
  }

  markCompleted(int? id) async {
    await DBHelper.update(id!);
    getTask();
    update();
  }

}
