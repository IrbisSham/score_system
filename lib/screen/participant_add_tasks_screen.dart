import 'package:flutter/material.dart';
import 'package:score_system/model/person.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import '../locator.dart';
import '../model/activity.dart';
import '../view/category_activities_view.dart';
import '../vocabulary/person_data.dart';

class AddParticipantTasksPage extends StatefulWidget {

  late Person? _person;
  late Person person;
  String _searchStr = "";
  late Activity _activitySelected;

  final String participantsTitle = "Поставьте участнику новую задачу";
  static final String ROUTE_NAME = '/participant_add_tasks';

  AddParticipantTasksPage(BuildContext context, Person? person) {
    if (person == null) {
      List<Person> persons = locator<PersonData>().getData();
      _person = persons.isEmpty ? null : persons.first;
    } else {
      _person = person;
    }
    this._person = person;
  }

  @override
  State<StatefulWidget> createState() => _AddParticipantTasksPageState();

}

class _AddParticipantTasksPageState extends State<AddParticipantTasksPage> {
  late TextEditingController searchController;
  int selectedIndex = 2;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget._person == null) {
      return Scaffold(
          body: SimpleDialog(title: Text('Не выбран участник!'))
      );
    } else {
      this.widget.person = this.widget._person!;
    }
    searchController = TextEditingController(text: this.widget._searchStr);
    // Start listening to changes.
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            this.widget.person.fio(),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      body:
        // SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        //     child:
            Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Expanded(child:
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child:
                      CategoryActivitiesView(),
                    ),
                  ),
                ]
            ),
          // ),
      bottomNavigationBar: MainBottomNavigationBar(context, selectedIndex),
    );
  }

}