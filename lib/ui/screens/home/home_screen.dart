import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_sat_c9/ui/bottom_sheets/add_bottom_sheet/add_bottom_sheet.dart';
import 'package:todo_sat_c9/ui/screens/home/todo_widget.dart';
import 'package:todo_sat_c9/ui/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigation(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: body(),
    );
  }

  Widget body() => Stack(
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
          SizedBox(height: 20,),
          buildAppBar(),
          CalendarTimeline(
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) => print(date),
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
              itemCount: 10,
              itemBuilder: (_, index) => TodoWidget(),
            ),
          ),
        ],
      ),
    ],
  );

  Widget buildFab() =>
      FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context,
              isScrollControlled: true,
              builder: (_) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: AddBottomSheet(),
                );
              });
        },
        child: const Icon(Icons.add),
      );

  Widget buildBottomNavigation() =>
      BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      );

  PreferredSizeWidget buildAppBar() =>
      AppBar(
        backgroundColor: Colors.transparent,
        title: Text("To Do List"),
      );
}
