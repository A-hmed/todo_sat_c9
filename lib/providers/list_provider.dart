import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_sat_c9/model/app_user.dart';
import 'package:todo_sat_c9/model/todo_dm.dart';

class ListProvider extends ChangeNotifier {
  List<TodoDM> todos = [];
  DateTime selectedDay = DateTime.now();

  void getTodosFromFirestore() async {
    todos.clear();
    var collectionRef =
    AppUser.getCollection().doc(AppUser.currentUser!.id)
        .collection(TodoDM.collectionName);

    QuerySnapshot snapShot = await collectionRef
        .orderBy("date")
        //.where("date", isEqualTo: Timestamp.fromDate(selectedDay))
        .get();
    List<QueryDocumentSnapshot> docs = snapShot.docs;

    for(int i = 0; i < docs.length; i++){
      var todo = TodoDM.fromJson(docs[i].data() as Map);
      if(todo.date.year == selectedDay.year && todo.date.month == selectedDay.month
       && todo.date.day == selectedDay.day){
        todos.add(todo);
      }
    }
    notifyListeners();
  }
}