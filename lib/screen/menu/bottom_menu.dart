import 'package:flutter/material.dart';
import 'package:score_system/current_data.dart';
import 'package:score_system/screen/participants_prize_screen.dart';
import '../../locator.dart';
import '../../navigation/pass_arguments.dart';
import '../encyclopedia_screen.dart';
import '../participant_tasks_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class BottomMenuItem {
  final int index;
  final String name;
  final Icon icon;
  BottomMenuItem(this.index, this.name, this.icon);
}

enum MENU_LABELS {
  TASKS,
  SUCCESS,
  ADD,
  ENCYCLOPEDIA,
  SETTINGS,
}

extension MENU_LABELS_Extension on MENU_LABELS {

  static final labels = {
    MENU_LABELS.TASKS: BottomMenuItem(0, 'BottomMenu.Tasks'.tr(), Icon(Icons.list)),
    MENU_LABELS.SUCCESS: BottomMenuItem(1, 'BottomMenu.Success'.tr(), Icon(Icons.wine_bar)),
    MENU_LABELS.ADD: BottomMenuItem(2, 'BottomMenu.Add'.tr(), Icon(Icons.add_circle_outline_rounded)),
    MENU_LABELS.ENCYCLOPEDIA: BottomMenuItem(3, 'BottomMenu.Encyclopedia'.tr(), Icon(Icons.help)),
    MENU_LABELS.SETTINGS: BottomMenuItem(3, 'BottomMenu.Settings'.tr(), Icon(Icons.settings)),
  };

  int get index => labels[this]!.index;

  String get name => labels[this]!.name;

  Icon get icon => labels[this]!.icon;

}

class MainBottomNavigationBar extends BottomNavigationBar {

  MainBottomNavigationBar(BuildContext context, int selectedIndex) : super(
    type: BottomNavigationBarType.fixed,
    currentIndex: selectedIndex,
    items: [
      BottomNavigationBarItem(
        icon: MENU_LABELS.TASKS.icon,
        label: MENU_LABELS.TASKS.name,
      ),
      BottomNavigationBarItem(
        icon: MENU_LABELS.SUCCESS.icon,
        label: MENU_LABELS.SUCCESS.name,
      ),
      BottomNavigationBarItem(
        icon: MENU_LABELS.ADD.icon,
        label: MENU_LABELS.ADD.name,
      ),
      BottomNavigationBarItem(
        icon: MENU_LABELS.ENCYCLOPEDIA.icon,
        label: MENU_LABELS.ENCYCLOPEDIA.name,
      ),
      BottomNavigationBarItem(
        icon: MENU_LABELS.SETTINGS.icon,
        label: MENU_LABELS.SETTINGS.name,
      ),
    ],
    onTap: (int index) {
      selectedIndex = index;
      MENU_LABELS menuLabels = MENU_LABELS.values[index];
      switch(menuLabels) {
        case MENU_LABELS.TASKS:
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
        case MENU_LABELS.SUCCESS:
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
        case MENU_LABELS.ENCYCLOPEDIA:
          Navigator.pushNamed(
            context,
            EncyclopediaPage.ROUTE_NAME,
          );
          break;
      }
    },
  );

}