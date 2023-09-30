import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_sat_c9/model/todo_dm.dart';
import 'package:todo_sat_c9/providers/list_provider.dart';
import 'package:todo_sat_c9/ui/utils/app_colors.dart';
import 'package:todo_sat_c9/ui/utils/app_theme.dart';

class TodoWidget extends StatelessWidget {
  TodoDM item;
  TodoWidget(this.item);
  late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(20)),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: .3,
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (_) {
                TodoDM.getCollection().doc(item.id).delete().timeout(Duration(milliseconds: 300),
                    onTimeout: (){
                      provider.getTodosFromFirestore();
                    });
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: MediaQuery.of(context).size.height * .13,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const VerticalDivider(
                color: AppColors.primiary,
                thickness: 3,
              ),
              SizedBox(
                width: 25,
              ),
               Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: AppTheme.taskTitleTextStyle,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      item.description,
                      textAlign: TextAlign.start,
                      style: AppTheme.taskDescriptionTextStyle,
                    )
                  ],
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColors.primiary,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: 32,
                  )),
              const SizedBox(
                width: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
