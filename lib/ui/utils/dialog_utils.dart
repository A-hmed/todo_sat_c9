import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class DialogUtils {
  static showLoading(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return const AlertDialog(
            content: Row(
              children: [
                Text("Loading"),
                Spacer(),
                CircularProgressIndicator()
              ],
            ),
          );
        });
  }
  static hideLoading(BuildContext context){
    Navigator.pop(context);
  }
  static showError(BuildContext context, String message){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Ok"))
            ],
          );
        });
  }
}
