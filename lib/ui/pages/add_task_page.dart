import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/button.dart';
import 'package:todo_app/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController controller = Get.put(TaskController());

  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(minutes: 15))).toString();
  DateTime date = DateTime.now();

  int selectedRemind = 5;
  String selectedRepeat = 'none';

  List<int> remindList = [5, 10, 15, 20];
  List<String> repeatList = ['none', 'Daily', 'Weekly', 'Monthly'];
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  int colorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage:AssetImage('images/person.jpeg')
            ),
          ),
          SizedBox(width: 12,)
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: primaryClr,), onPressed:(){Get.back();} ,
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Add Task',
                style: title1,
              ),
            ),
            inputField('Title', 'enter title here',
                controller: titleController),
            const SizedBox(
              height: 10,
            ),
            inputField('Note', 'enter note here', controller: noteController),
            const SizedBox(
              height: 10,
            ),
            inputField('Date', DateFormat.yMd().format(date).toString(),
                widget:  IconButton(
                  onPressed: () async {
                   DateTime? pickedDate = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(2020), lastDate: DateTime(2030));
                    setState((){
                      date = pickedDate!;
                    });
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    size: 22,
                    color: Colors.grey,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: inputField('Start Time', startTime,
                      widget: const Icon(
                        Icons.access_time_outlined,
                        size: 22,
                        color: Colors.grey,
                      )),
                ),
                Expanded(
                  child: inputField('End Time', endTime,
                      widget: IconButton(
                        onPressed: ()async{
                          TimeOfDay ? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));
                            String formatedTime = pickedTime!.format(context);
                          setState((){
                            endTime =formatedTime;
                          });
                        },
                        icon: const Icon(
                          Icons.access_time_outlined,
                          size: 22,
                          color: Colors.grey,
                        ),
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            inputField('Remind', ' $selectedRemind minutes early ',
                widget: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    underline: Container(
                      height: 0,
                    ),
                    value: selectedRemind,
                    items: remindList
                        .map<DropdownMenuItem<int>>((int e) =>
                            DropdownMenuItem<int>(
                                value: e, child: Text(e.toString())))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRemind = int.parse(value.toString());
                      });
                    })),
            const SizedBox(
              height: 10,
            ),
            inputField('Repeat', ' $selectedRepeat ',
                widget: DropdownButton(
                    value: selectedRepeat,
                    dropdownColor: Colors.blueGrey,
                    underline: Container(
                      height: 0,
                    ),
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String e) =>
                            DropdownMenuItem<String>(
                                value: e.toString(), child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRepeat = value.toString();
                      });
                    })),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        'Colors',
                        style: title1.copyWith(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        colorIndex = index;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: index == 0
                                          ? bluishClr
                                          : index == 1
                                              ? pinkClr
                                              : orangeClr,
                                      child: index == colorIndex
                                          ? const Icon(
                                              Icons.check,
                                              size: 14,
                                            )
                                          : null,
                                    ),
                                  ),
                                )),
                      ),
                    )
                  ],
                ),
                MyButton(label: 'Create Task', onTap: () {validateTask ();})
              ],
            )
          ],
        ),
      ),
    );
  }
  validateTask () {
    if ( titleController.text.isEmpty){
      Get.snackbar('Hint', 'please fill all items',colorText: pinkClr,snackPosition:SnackPosition.TOP,backgroundColor: Colors.white,duration: const Duration(seconds: 3));
    }else {
      addTaskToDb();
      Get.back();
    }
  }
  addTaskToDb() async {
    await controller.addTask(
        Task(
             title: titleController.text,
             note:noteController.text,
             isCompleted:0,
             date:DateFormat.yMd().format(DateTime.now()),
             startTime:startTime,
             endTime:endTime,
             color:colorIndex,
             remind:selectedRemind,
             repeat:selectedRepeat
         )    );
    await controller.getTask();

  }
}

