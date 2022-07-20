import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:score_system/model/entity.dart';
import 'package:score_system/model/person.dart';
import 'package:score_system/model/task.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:score_system/util/date_util.dart';
import 'package:score_system/vocabulary/constant.dart';
import 'package:score_system/vocabulary/task_data.dart';
import 'package:tuple/tuple.dart';

import '../main.dart';
import '../model/activity.dart';
import '../model/person_task_progress.dart';
import '../vocabulary/person_data.dart';

class AddParticipantTasksPage extends StatefulWidget {

  late BuildContext _ctx;
  late Person? _person;
  late Person person;
  late List<Activity> _activities;
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
  }

  @override
  State<StatefulWidget> createState() => _AddParticipantTasksPageState();

}

class _AddParticipantTasksPageState extends State<AddParticipantTasksPage> {
  late TextEditingController searchController;
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
    if (this.widget._person == null) {
      return Scaffold(
          body: SimpleDialog(title: Text('Не выбран участник!'))
      );
    } else {
      this.widget.person = this.widget._person!;
    }
    searchController = TextEditingController(text: _searchString);
    // Start listening to changes.
    searchController.addListener(() => _refreshActivities(searchController.text));
    List<Tuple2<Activity, List<Activity>>> categoriesWithActivities = getIt<HierarchEntityUtil>().getTopDataWithChildren(this.widget._activities).cast<Tuple2<Activity, List<Activity>>>();
    categoriesWithActivities.add(Tuple2(activityDummy, List.empty()));
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
              ),
              Container(
                height: MediaQuery.of(context).size.height - 130,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child:
                  Row(
                    children:
                      <Widget>[
                        ...categoriesWithActivities.map( (categoryWithActivities) =>
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child:
                                      Text(
                                        categoryWithActivities.item1.name!,
                                        textAlign: TextAlign.left,
                                        style:
                                        TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                        ),
                                      ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height / 5,
                                    child:
                                    SingleChildScrollView(
                                      child: GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: MediaQuery.of(context).size.width / 4,
                                              // childAspectRatio: 4,
                                              // crossAxisSpacing: 0,
                                              mainAxisSpacing: 20),
                                          itemCount: categoryWithActivities.item2.length,
                                          itemBuilder: (BuildContext ctx, index) {
                                            return GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    this.widget._activitySelected = categoryWithActivities.item2[index];
                                                    this.widget._ctx = context;
                                                  });
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child:
                                                    SingleChildScrollView(
                                                      child:
                                                        Container(
                                                          alignment: Alignment.center,
                                                          height: 130,
                                                          width: MediaQuery.of(context).size.width / 2,
                                                          padding: EdgeInsets.only(bottom: 30),
                                                          child : FittedBox(
                                                            fit: BoxFit.fill,
                                                            child: Text(
                                                              categoryWithActivities.item2[index].name!,
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 32,
                                                              ),
                                                            ),
                                                          ),
                                                          decoration: BoxDecoration(
                                                            color: Colors.primaries[index],
                                                            border: Border.all(color: Colors.white, width: 2, style: BorderStyle.solid),
                                                          ),
                                                        ),
                                                    ),
                                                ));
                                            }
                                      )
                                    )
                                  ),
                                ],
                              )
                          ).toList(),
                        Container(),
                    ],
                  ),
              ),
            ]
        ),
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