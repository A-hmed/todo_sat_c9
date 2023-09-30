import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_sat_c9/model/app_user.dart';
import 'package:todo_sat_c9/ui/screens/auth/register/register.dart';
import 'package:todo_sat_c9/ui/screens/home/home_screen.dart';
import 'package:todo_sat_c9/ui/utils/constants.dart';
import 'package:todo_sat_c9/ui/utils/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Login"),
        toolbarHeight: MediaQuery.of(context).size.height * .1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Welcome back !",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                onChanged: (text){
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
                onChanged: (text){
                  password = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Password",
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text("Login", style: TextStyle(fontSize: 18),),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
              const SizedBox(height: 18,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: const Text(
                  "Create account",
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void login() async {
    // if(rePassword != password){
    //   //todo: show Error message
    //   return;
    // }
    try{
      DialogUtils.showLoading(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AppUser.currentUser = await getUserFromfirestore(credential.user!.uid);
      DialogUtils.hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch(e){
      DialogUtils.hideLoading(context);
      print(e.code);
      if (e.code == 'user-not-found') {
        DialogUtils.showError(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        DialogUtils.showError(context, 'Wrong password provided for that user.');
      }else if(e.code == "INVALID_LOGIN_CREDENTIALS"){
        DialogUtils.showError(context, 'Invalid email');
      }else {
        DialogUtils.showError(context, Constants.defaultErrorMessage);
      }

    }
  }

  Future<AppUser> getUserFromfirestore(String uid) async {
   DocumentSnapshot<AppUser> doc =  await AppUser.getCollection().doc(uid).get();
   return doc.data()!;
  }
}