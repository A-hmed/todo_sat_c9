import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  static AppUser? currentUser;
  static const String collectionName = "users";
  late String id;
  late String userName;
  late String email;


  AppUser({required this.id,
    required this.userName,
    required this.email});

  AppUser.fromJson(Map<String, dynamic> json){
    id = json["id"] ;
    userName = json["user_name"];
    email = json["email"];
  }
  Map<String, Object?> toJson(){
    return {
      "id": id,
      "user_name": userName,
      "email": email
    };
  }

  static CollectionReference<AppUser> getCollection(){
    return  FirebaseFirestore.instance.collection(AppUser.collectionName)
        .withConverter<AppUser>(
        fromFirestore: (snapshot, _){
          return AppUser.fromJson(snapshot.data()!);
        },
        toFirestore: (user, _){
          return user.toJson();
        });
  }
}