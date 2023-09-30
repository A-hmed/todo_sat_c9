import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDM{
  static String collectionName = "todo";
  late String id;
  late String title;
  late String description;
  late bool isDone;
  late DateTime date;

  TodoDM({required this.id, required this.title,required this.description,required this.isDone,
    required this.date});

  TodoDM.fromJson(Map json){
    id = json["id"];
    title = json["title"];
    description = json["description"];
    isDone = json["isDone"];
    Timestamp dateAsTimeStamp = json["date"];
    date = dateAsTimeStamp.toDate();
  }

  static CollectionReference getCollection(){
    return FirebaseFirestore.instance.collection(collectionName);
  }
}