import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sat_c9/model/app_user.dart';
import 'package:todo_sat_c9/providers/list_provider.dart';
import 'package:todo_sat_c9/ui/screens/auth/login/login.dart';
import 'package:todo_sat_c9/ui/screens/home/todo_widget.dart';
import 'package:todo_sat_c9/ui/utils/app_colors.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getTodosFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
                flex: 17,
                child: Container(
                  color: AppColors.primiary,
                )),
            Expanded(
                flex: 83,
                child: Container(
                  color: AppColors.accent,
                ))
          ],
        ),
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            buildAppBar(),
            CalendarTimeline(
              initialDate: provider.selectedDay,
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateSelected: (date) {
                provider.selectedDay = date;
                provider.getTodosFromFirestore();
              },
              leftMargin: 20,
              monthColor: Colors.black,
              dayColor: Colors.black,
              activeDayColor: AppColors.primiary,
              activeBackgroundDayColor: AppColors.white,
              dotsColor: AppColors.transparent,
              locale: 'en_ISO',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.todos.length,
                itemBuilder: (_, index) => TodoWidget(provider.todos[index]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  PreferredSizeWidget buildAppBar() => AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Welcome ${AppUser.currentUser!.userName}"),
        actions: [
          InkWell(
              onTap: () {
                AppUser.currentUser = null;
                provider.todos.clear();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Icon(Icons.logout))
        ],
      );
}
