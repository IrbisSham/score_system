import 'package:flutter/material.dart';
import 'package:score_system/current_data.dart';
import 'package:score_system/screen/participants_prize_screen.dart';

import '../../navigation/pass_arguments.dart';
import '../encyclopedia_screen.dart';
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
          Navigator.pushNamed(
            context,
            ParticipantTasksPage.ROUTE_NAME,
            arguments: PersonDatesIntervalArguments(
                CURRENT_USER,
                CURRENT_DATA_MIN,
                CURRENT_DATA_MAX
            ),
          );
          break;
        case 1:
          Navigator.pushNamed(
            context,
            ParticipantPrizePage.ROUTE_NAME,
            arguments: PersonDatesIntervalArguments(
                CURRENT_USER,
                CURRENT_DATA_MIN,
                CURRENT_DATA_MAX
            ),
          );
          break;
        case 2:
          Navigator.pushNamed(
            context,
            EncyclopediaPage.ROUTE_NAME,
          );
          break;
      }
    },
  );

}