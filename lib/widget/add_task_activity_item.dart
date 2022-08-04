import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../model/activity.dart';

class AddTaskActivityItem extends StatelessWidget {
  final Tuple2<Activity, List<Activity>> categoryWithActivities;

  AddTaskActivityItem(this.categoryWithActivities);

  @override
  Widget build(BuildContext context) {
  return
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
        // GridView(
        //   padding: const EdgeInsets.all(25),
        //   children:
        //     categoryWithActivities.item2
        //       .map((activity) =>
        //         InkWell(
        //           onTap: () => {},
        //           splashColor: Theme.of(context).primaryColor,
        //           borderRadius: BorderRadius.circular(15),
        //           child:
        //           Container(
        //             padding: const EdgeInsets.all(15),
        //             child:
        //             Text(
        //               activity.name!,
        //               style: Theme.of(context).textTheme.titleSmall,
        //             ),
        //             decoration:
        //             BoxDecoration(
        //               gradient:
        //               LinearGradient(
        //                 colors: [
        //                   Theme.of(context).primaryColor.withOpacity(0.7),
        //                   Theme.of(context).primaryColor,
        //                 ],
        //                 begin: Alignment.topLeft,
        //                 end: Alignment.bottomRight,
        //               ),
        //               borderRadius: BorderRadius.circular(15),
        //             ),
        //           ),
        //         ),
        //     ).toList()
        //     ..add(
        //         InkWell(
        //           onTap: () => {},
        //           splashColor: Theme.of(context).primaryColor,
        //           borderRadius: BorderRadius.circular(15),
        //           child:
        //           Container(
        //             padding: const EdgeInsets.all(15),
        //             child:
        //               ClipRRect(
        //                   borderRadius: BorderRadius.circular(50),
        //                   child:
        //                     Icon(Icons.add,
        //                         color: Theme.of(context).colorScheme.primary,
        //                       size: 20,
        //                     )
        //               ),
        //             decoration:
        //               BoxDecoration(
        //                 gradient:
        //                 LinearGradient(
        //                   colors: [
        //                     Theme.of(context).primaryColor.withOpacity(0.7),
        //                     Theme.of(context).primaryColor,
        //                   ],
        //                   begin: Alignment.topLeft,
        //                   end: Alignment.bottomRight,
        //                 ),
        //                 borderRadius: BorderRadius.circular(15),
        //               ),
        //           ),
        //         )
        //     ),
        //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 200,
        //     childAspectRatio: 3 / 2,
        //     crossAxisSpacing: 20,
        //     mainAxisSpacing: 20,
        //   ),
        // ),
      ],
    );
  }
}


