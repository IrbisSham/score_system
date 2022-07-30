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
  late List<Tuple2<Activity, List<Activity>>> _categoriesWithActivities;

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
        .getTopDataWithChildren(_activities, '');
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
                        ...this.widget._categoriesWithActivities.map( (categoryWithActivities) =>
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
                                          color: Theme.of(context).colorScheme.secondary,
                                          fontSize: 32,
                                        ),
                                      ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height / 5,
                                    child:
                                      Container(
                                      // Expanded(child:
                                    //     SizedBox(
                                    //         height: 200.0,
                                    //     child:
                                    //     SingleChildScrollView(
                                    //       child: GridView.builder(
                                    //       shrinkWrap: true,
                                    //       gridDelegate:
                                    //         // SliverGridDelegateWithMaxCrossAxisExtent(
                                    //         //   maxCrossAxisExtent: MediaQuery.of(context).size.width / 4,
                                    //         //   childAspectRatio: 4,
                                    //         //   crossAxisSpacing: 0,
                                    //         //   mainAxisSpacing: 20
                                    //         // ),
                                    //         SliverGridDelegateWithFixedCrossAxisCount(
                                    //           crossAxisCount: 2,
                                    //           childAspectRatio: 3 / 2,
                                    //           crossAxisSpacing: 10,
                                    //           mainAxisSpacing: 10,
                                    //         ),
                                    //       itemCount: categoryWithActivities.item2.length,
                                    //       itemBuilder: (BuildContext ctx, index) {
                                    //         return GestureDetector(
                                    //             onTap: (){
                                    //               setState(() {
                                    //                 this.widget._activitySelected = categoryWithActivities.item2[index];
                                    //                 SimpleDialog(title: Text('Выбрана активность ${this.widget._activitySelected.name}'));
                                    //               });
                                    //             },
                                    //             child: Expanded(
                                    //                 child:
                                    //                 SingleChildScrollView(
                                    //                   child:
                                    //                     Row(children: [
                                    //                       Container(
                                    //                         alignment: Alignment.center,
                                    //                         height: 130,
                                    //                         width: MediaQuery.of(context).size.width / 2,
                                    //                         padding: EdgeInsets.only(bottom: 30),
                                    //                         child : FittedBox(
                                    //                           fit: BoxFit.fill,
                                    //                           child: Text(
                                    //                             categoryWithActivities.item2[index].name!,
                                    //                             textAlign: TextAlign.center,
                                    //                             style: TextStyle(
                                    //                               color: Theme.of(context).colorScheme.secondary,
                                    //                               fontSize: 32,
                                    //                             ),
                                    //                           ),
                                    //                         ),
                                    //                         decoration: BoxDecoration(
                                    //                           color: Colors.primaries[index],
                                    //                           border: Border.all(color: Theme.of(context).colorScheme.secondary,
                                    //                               width: 2,
                                    //                               style: BorderStyle.solid
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                       if (index == categoryWithActivities.item2.length - 1)
                                    //                         Container(
                                    //                           alignment: Alignment.center,
                                    //                           height: 130,
                                    //                           width: MediaQuery.of(context).size.width / 2,
                                    //                           padding: EdgeInsets.only(bottom: 30),
                                    //                           child : FittedBox(
                                    //                             fit: BoxFit.fill,
                                    //                             child:
                                    //                               IconButton(
                                    //                                 tooltip: "Добавить",
                                    //                                 icon: Icon(
                                    //                                   Icons.add,
                                    //                                   color: Theme.of(context).colorScheme.secondary,
                                    //                                 ),
                                    //                                 onPressed: () {
                                    //                                   SimpleDialog(title: Text('Требует реализации экрана добавления активности'));
                                    //                                 },
                                    //                               )
                                    //                           ),
                                    //                           decoration: BoxDecoration(
                                    //                             color: Colors.primaries[index],
                                    //                             border: Border.all(color: Theme.of(context).colorScheme.secondary,
                                    //                                 width: 2,
                                    //                                 style: BorderStyle.solid),
                                    //                           ),
                                    //                         )
                                    //                     ],)
                                    //                 ),
                                    //             ));
                                    //         }
                                    //   )
                                    // )
                                    // )
                                  ),
                                // ),
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

  void _refreshActivities(String searchString) {
    setState(() {
      this.widget._categoriesWithActivities = HierarchEntity
          .getTopDataWithChildren(this.widget._activities, searchString);
    });
  }

}