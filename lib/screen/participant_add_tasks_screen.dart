import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:score_system/model/person.dart';
import 'package:score_system/model/person_progress.dart';
import 'package:score_system/model/task.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:score_system/service/person_service.dart';
import 'package:score_system/util/date_util.dart';
import 'package:score_system/vocabulary/constant.dart';
import 'package:score_system/vocabulary/task_data.dart';

import '../main.dart';
import '../model/person_task_progress.dart';

class AddParticipantTasksArguments {
  final Person _person;
  AddParticipantTasksArguments(this._person);
}

class AddParticipantTasksPage extends StatefulWidget {

  final String participantsTitle = "Поставьте участнику новую задачу";
  static final String ROUTE_NAME = '/participant_add_tasks';

  const AddParticipantTasksPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddParticipantTasksPageState();

}

class _AddParticipantTasksPageState extends State<AddParticipantTasksPage> {
  late TextEditingController searchController;
  late Person _person;
  String _searchString = "";
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
    final args = ModalRoute.of(context)!.settings.arguments as AddParticipantTasksArguments;
    _person = args._person;
    searchController = TextEditingController(text: _searchString);
    // Start listening to changes.
    searchController.addListener(() => _refreshActivities(searchController.text));
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            _person.fio(),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      body:
      Row(
          children: [
            Column(
              children: [
                Container(
                  child:
                    Text(
                      'Фильтр по словоформе'
                    ),
                  width: MediaQuery.of(context).size.width / 5,
                ),
                Container(
                  child:
                    TextField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter], // Only numbers can be entered
                    ),
                  width: MediaQuery.of(context).size.width * 4 / 5,
                ),
              ],
            )


            ),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child:
              Row(
                mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    // alignment: Alignment.center,
                    child:
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child:
                          _person.avaPath != null ?
                          Image.asset(
                            _person.avaPath!,
                          ) : Icon(Icons.person, color: Theme.of(context).colorScheme.primary)
                      ),
                      radius: 52,
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 5,
                      // alignment: Alignment.center,
                      // padding: EdgeInsets.only(bottom: 25, left: 20, right: 20),
                      child: Container(
                        // padding: EdgeInsets.only(left: 30),
                        alignment: Alignment.center,
                        child:
                        Text(
                          getIt<DateUtil>().getDateNowInStr(),
                          style: TextStyle(
                            fontSize: 26,
                            fontFamily: FONT_FAMILY_SECOND,
                          ),
                        ),
                      )
                  ),
                  Column(children: [
                    Container(

                    ),
                    Container(

                    ),
                  ],)
                ],
              ),
            ),
          ]
      ),
      // );
      // }),
      bottomNavigationBar: MainBottomNavigationBar(context, selectedIndex),
    );

  }

  void addRemoveTaskFact(PersonTaskProgress personTaskProgress, int sum, bool status) {
    DateTime now = DateTime.now();
    List<TaskFact> data = getIt<TaskFactData>().getData();
    List<TaskFact> taskFacts = data
        .where((fact) =>
    personTaskProgress.id == PersonTaskProgress.makeId(fact)).toList()
    ;
    bool isCreate = false;
    if (taskFacts.isEmpty) {
      isCreate = true;
    }
    if (status) {
      if (isCreate) {
        int taskFactCnt = data
            .where((fact) =>
        personTaskProgress.person.id == fact.person.id
            && personTaskProgress.taskPlan.id == fact.taskPlan.id
            && fact.dtExecute.isSameDate(now)).length;
        TaskFact taskFact = TaskFact(id: -1,
            taskPlan: personTaskProgress.taskPlan,
            person: _person,
            dtPlan: personTaskProgress.dt,
            dtExecute: now,
            sum: sum,
            status: TaskStatus.DONE.status,
            cnt: taskFactCnt + 1);
        int id = getIt<TaskFactData>().addEntity(taskFact);
      }
    } else {
      if (!isCreate) {
        getIt<TaskFactData>().removeEntity(taskFacts.first);
      }
    }
  }

  void _refreshActivities(String searchString) {

  }

}