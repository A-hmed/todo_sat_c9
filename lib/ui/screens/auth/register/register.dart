import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_sat_c9/model/app_user.dart';
import 'package:todo_sat_c9/ui/screens/home/home_screen.dart';
import 'package:todo_sat_c9/ui/utils/constants.dart';
import 'package:todo_sat_c9/ui/utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "register";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";
  String password = "";
  String username = "";
  String rePassword = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
              TextFormField(
                onChanged: (text) {
                  username = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "user name",
                  ),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Email",
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Password",
                  ),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  rePassword = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Re password",
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              ElevatedButton(
                  onPressed: () {
                    register();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "Create account",
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    // if(rePassword != password){
    //   //todo: show Error message
    //   return;
    // }
   try{
     DialogUtils.showLoading(context);
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password,
     );
     AppUser user = AppUser(id: credential.user!.uid,
         userName: username, email: email);
     await addUserToFirestore(user);
     AppUser.currentUser = user;
     DialogUtils.hideLoading(context);
     Navigator.pushReplacementNamed(context, HomeScreen.routeName);
   } on FirebaseAuthException catch(e){
     DialogUtils.hideLoading(context);
     DialogUtils.showError(context, e.message ?? Constants.defaultErrorMessage);
   }
  }
  addUserToFirestore(AppUser user)async{
    CollectionReference<AppUser> usersCollection = AppUser.getCollection();
    DocumentReference<AppUser> docRef = usersCollection.doc(user.id);
    await docRef.set(user);

  }
}

