import 'package:flutter/material.dart';
import 'package:todo_sat_c9/ui/utils/app_colors.dart';
import 'package:todo_sat_c9/ui/utils/app_theme.dart';
import 'package:todo_sat_c9/ui/widgets/my_text_field.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .45,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Add new task", textAlign: TextAlign.center, style: AppTheme.bottomSheetTitleTextStyle,),
          SizedBox(height: 12,),
          MyTextField(hintText: "Enter task title",),
          SizedBox(height: 4,),
          MyTextField(hintText: "Enter task details",),
          SizedBox(height: 22,),
          Text("Select date", style: AppTheme.bottomSheetTitleTextStyle.copyWith(
            fontWeight: FontWeight.normal
          ),),
          Text("23/9/2023", textAlign: TextAlign.center,
              style: AppTheme.bottomSheetTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w300,
                color: AppColors.lightBlack
              )),
          Spacer(),
          ElevatedButton(onPressed: (){},
              child: Text("Add"))
        ],
      ),
    );
  }
}
