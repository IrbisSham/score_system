import 'package:flutter/material.dart';
import 'package:score_system/current_data.dart';
import 'package:score_system/model/entity.dart';
import 'package:score_system/screen/participant_add_task_screen.dart';
import 'package:score_system/screen/participants_success_screen.dart';
import '../../navigation/pass_arguments.dart';
import '../encyclopedia_screen.dart';
import '../participant_tasks_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class BottomMenuItem extends IndexName {
  final Icon icon;

  BottomMenuItem({required int index, required String name, required Icon icon}) :
        this.icon = icon,
        super(index: index, name: name);

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
    MENU_LABELS.TASKS: BottomMenuItem(index: 0, name: 'BottomMenu.Tasks'.tr(), icon: Icon(Icons.list)),
    MENU_LABELS.SUCCESS: BottomMenuItem(index: 1, name: 'BottomMenu.Success'.tr(), icon: Icon(Icons.wine_bar)),
    MENU_LABELS.ADD: BottomMenuItem(index: 2, name: 'BottomMenu.Add'.tr(), icon: Icon(Icons.add_circle_outline_rounded)),
    MENU_LABELS.ENCYCLOPEDIA: BottomMenuItem(index: 3, name: 'BottomMenu.Encyclopedia'.tr(), icon: Icon(Icons.help)),
    MENU_LABELS.SETTINGS: BottomMenuItem(index: 3, name: 'BottomMenu.Settings'.tr(), icon: Icon(Icons.settings)),
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
        case MENU_LABELS.SETTINGS:
          throw UnsupportedError("Not realized yet");
        case MENU_LABELS.ADD:
          Navigator.pushNamed(
            context,
            AddParticipantTaskPage.ROUTE_NAME,
            arguments: PersonDatesIntervalArguments(
                CURRENT_USER,
                CURRENT_DATA_MIN,
                CURRENT_DATA_MAX
            ),
          );
          break;
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
            ParticipantSuccessPage.ROUTE_NAME,
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