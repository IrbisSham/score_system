import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_system/model/entity.dart';
import 'package:score_system/model/person.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:tuple/tuple.dart';

import '../bloc/category_activity_bloc.dart';
import '../bloc/category_activity_event.dart';
import '../main.dart';
import '../model/activity.dart';
import '../vocabulary/person_data.dart';
import '../widget/add_task_activity_item.dart';

class AddParticipantTasksPage extends StatefulWidget {

  late BuildContext _ctx;
  late Person? _person;
  late Person person;
  late List<Activity> _activities;
  late List<Tuple2<Activity, List<Activity>>> _categoriesWithActivities;
  String _searchStr = "";
  late Activity _activitySelected;

  final String participantsTitle = "Поставьте участнику новую задачу";
  static final String ROUTE_NAME = '/participant_add_tasks';

  AddParticipantTasksPage(BuildContext context, Person? person, List<Activity> activities){
    this._ctx = context;
    if (person == null) {
      List<Person> persons = getIt<PersonData>().getData();
      _person = persons.isEmpty ? null : persons.first;
    } else {
      _person = person;
    }
    this._person = person;
    this._ctx = context;
    this._activities = activities;
    _categoriesWithActivities = HierarchEntity
        .getTopDataWithChildren(_activities);
  }

  @override
  State<StatefulWidget> createState() => _AddParticipantTasksPageState();

}

class _AddParticipantTasksPageState extends State<AddParticipantTasksPage> {
  late TextEditingController searchController;
  int selectedIndex = 2;
  ValueNotifier<String> _searchStringNotifier = ValueNotifier("");

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
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child:
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Фраза для поиска",
                            hintText: "Введите фразу для поиска",
                            prefixIcon: Icon(Icons.search),
                            border:
                              OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0))
                              )
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter], // Only numbers can be entered
                        controller: searchController,
                        onChanged: (value) =>
                              BlocProvider.of<CategoryActivityBloc>(context)
                                  .add(SearchWordTyped(value)),
                      ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Expanded(child:
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child:
                        AddTaskActivityItems(),
                    ),
                  ),
                ]
            ),
          // ),
      bottomNavigationBar: MainBottomNavigationBar(context, selectedIndex),
    );
  }

}