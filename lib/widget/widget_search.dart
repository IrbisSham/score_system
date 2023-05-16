import 'package:flutter/material.dart';
import 'package:score_system/model/entity.dart';

import '../model/person.dart';
import '../navigation/pass_arguments.dart';
import '../screen/participant_add_task_schedule_screen.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: const CircularProgressIndicator(),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text('Ничего не найдено!'),
    );
  }
}

class SearchErrorWidget extends StatelessWidget {
  const SearchErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error_outline, color: Colors.red[300], size: 80.0),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'Исчерпан лимит ожидания',
              style: TextStyle(
                color: Colors.red[300],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryActivitiesResultWidget extends StatelessWidget {
  final Person person;
  final List<CategoryEntities> items;

  const CategoryActivitiesResultWidget({Key? key, required this.person, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children:
        <Widget>[
          ...items.map( (categoryWithActivities) =>
              Column(
                  children: [
                    Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child:
                      Text(
                        categoryWithActivities.item1.name!,
                        textAlign: TextAlign.left,
                        style:
                        TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                        ),
                      ),
                    ),
                    SizedBox (
                        height: 400,
                        width: 800,
                        child:
                        GridView(
                          children:
                          categoryWithActivities.item2
                              .map((activity) =>
                              InkWell(
                                onTap: () => {
                                  Navigator.pushNamed(
                                    context,
                                    AddParticipantTaskSchedulePage.ROUTE_NAME,
                                    arguments:
                                      PersonHierarchEntityArguments(
                                          person,
                                          activity,
                                        ),
                                  )
                                },
                                splashColor: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15),
                                child:
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  child:
                                  Text(
                                    activity.name!,
                                    style: Theme.of(context).textTheme.titleMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                  decoration:
                                  BoxDecoration(
                                    gradient:
                                    LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor.withOpacity(0.7),
                                        Theme.of(context).primaryColor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                          ).toList()
                            ..add(
                                InkWell(
                                  onTap: () => {
                                },
                                  splashColor: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                  child:
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      child:
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child:
                                          Icon(Icons.add,
                                            color: Theme.of(context).colorScheme.secondary,
                                            size: 60,
                                          )
                                      ),
                                      decoration:
                                      BoxDecoration(
                                        gradient:
                                        LinearGradient(
                                          colors: [
                                            Theme.of(context).primaryColor.withOpacity(0.7),
                                            Theme.of(context).primaryColor,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                )
                            ),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                        )
                    )
                  ]
              )
          ).toList(),
        ]
    );
  }
}