import 'package:flutter/material.dart';
import 'package:score_system/model/person.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import '../current_data.dart';
import '../locator.dart';
import '../navigation/pass_arguments.dart';
import '../view/category_activities_view.dart';
import '../vocabulary/person_data.dart';

class AddParticipantTaskPage extends StatefulWidget {

  Person? _person;
  final String _searchStr = "";

  final String participantsTitle = "Поставьте участнику новую задачу";
  static const String ROUTE_NAME = '/participant_add_task';

  AddParticipantTaskPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddParticipantTaskPageState();

}

class _AddParticipantTaskPageState extends State<AddParticipantTaskPage> {
  late TextEditingController searchController;
  int selectedIndex = 2;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Object? arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null) {
      final args = arguments as PersonArguments;
      widget._person = args.person;
    }
    if (widget._person == null) {
      List<Person> persons = locator<PersonData>().getData().where((person) => person.isParticipant).toList();
      widget._person = persons.isEmpty ? CURRENT_USER : persons.first;
    }

    searchController = TextEditingController(text: this.widget._searchStr);
    // Start listening to changes.
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            this.widget._person!.fio(),
            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
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
                      CategoryActivitiesView(this.widget._person!),
                    ),
                  ),
                ]
            ),
          // ),
      bottomNavigationBar: MainBottomNavigationBar(context, selectedIndex),
    );
  }

}