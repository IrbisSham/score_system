import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_activity_bloc.dart';
import '../bloc/category_activity_state.dart';

class AddTaskActivityItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  return
    BlocBuilder<CategoryActivityBloc, CategoryActivityState>(
      builder: (context, state) {
        if (state is CategoryActivityPresented) {
          var items = state.list;
          return
            Column(
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
                                      onTap: () => {},
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
                                        onTap: () => {},
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
        } else {
          return Container();
        }
      },
    );
  }
}


