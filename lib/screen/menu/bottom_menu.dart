import 'package:flutter/material.dart';
import 'package:score_system/current_data.dart';

import '../participant_tasks_screen.dart';

class MainBottomNavigationBar extends BottomNavigationBar{

  MainBottomNavigationBar(BuildContext context, int selectedIndex) : super(
    type: BottomNavigationBarType.fixed,
    currentIndex: selectedIndex,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: "Задачи",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.wine_bar),
        label: "Успехи",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline_rounded),
        label: "Добавить",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.help),
        label: "Энциклопедия",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Настройки",
      ),
    ],
    onTap: (int index) {
      selectedIndex = index;
      switch(index) {
        case 0:
          break;
        case 1:

          break;
      }
    },
  );

}