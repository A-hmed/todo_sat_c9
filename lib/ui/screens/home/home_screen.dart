import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_sat_c9/model/app_user.dart';
import 'package:todo_sat_c9/ui/bottom_sheets/add_bottom_sheet/add_bottom_sheet.dart';
import 'package:todo_sat_c9/ui/screens/home/tabs/list_tab.dart';
import 'package:todo_sat_c9/ui/screens/home/tabs/settings.dart';
import 'package:todo_sat_c9/ui/screens/home/todo_widget.dart';
import 'package:todo_sat_c9/ui/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigation(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: body(),
    );
  }

  Widget body() => currentTabIndex == 0 ? ListTab() : SettingsTab();

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
          onTap: (index){
            currentTabIndex = index;
            setState(() {});
          },
          currentIndex: currentTabIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      );

  PreferredSizeWidget buildAppBar() =>
      AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Welcome ${AppUser.currentUser!.userName}"),
      );
}
