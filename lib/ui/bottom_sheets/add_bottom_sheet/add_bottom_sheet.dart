import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sat_c9/model/todo_dm.dart';
import 'package:todo_sat_c9/providers/list_provider.dart';
import 'package:todo_sat_c9/ui/utils/app_colors.dart';
import 'package:todo_sat_c9/ui/utils/app_theme.dart';
import 'package:todo_sat_c9/ui/widgets/my_text_field.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDay = DateTime.now();
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * .45,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add new task",
            textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle,
          ),
          SizedBox(
            height: 12,
          ),
          MyTextField(
            hintText: "Enter task title",
            controller: titleController,
          ),
          SizedBox(
            height: 4,
          ),
          MyTextField(
            hintText: "Enter task details",
            controller: descriptionController,
          ),
          SizedBox(
            height: 22,
          ),
          Text(
            "Select date",
            style: AppTheme.bottomSheetTitleTextStyle
                .copyWith(fontWeight: FontWeight.normal),
          ),
          InkWell(
            onTap: () {
              showMyDatePicker();
            },
            child: Text(
                "${selectedDay.day}/${selectedDay.month}/${selectedDay.year}",
                textAlign: TextAlign.center,
                style: AppTheme.bottomSheetTitleTextStyle.copyWith(
                    fontWeight: FontWeight.w300, color: AppColors.lightBlack)),
          ),
          Spacer(),
          ElevatedButton(
              onPressed: () {
                addTodoToFirestore();
              },
              child: Text("Add"))
        ],
      ),
    );
  }

  void addTodoToFirestore() {
    CollectionReference todosRef =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);

    DocumentReference docRef = todosRef.doc();
    docRef.set({
      "id": docRef.id,
      "title": titleController.text,
      "description": descriptionController.text,
      "date": selectedDay,
      "isDone": false
    }).timeout(Duration(milliseconds: 300), onTimeout: () {
      provider.getTodosFromFirestore();
      Navigator.pop(context);
    });
  }

  void showMyDatePicker() async {
    selectedDay = await showDatePicker(
            context: context,
            initialDate: selectedDay,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365))) ??
        selectedDay;
    setState(() {});
  }
}
