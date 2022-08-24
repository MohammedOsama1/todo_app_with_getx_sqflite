import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/ui/pages/home_page.dart';
import 'package:todo_app/ui/theme.dart';


void main() async{
  final TaskController controller = Get.put(TaskController());

  WidgetsFlutterBinding.ensureInitialized();
 await DBHelper.crate().then((value) {
   controller.getTask();
 });
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'Flutter Demo',
      theme: Themes.customLight,
      darkTheme: Themes.customDark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
