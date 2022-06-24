import 'package:flutter/material.dart';
import 'package:score_system/model/person.dart';

import '../current_data.dart';

class ButtonGen {

  static MaterialButton btnByListAndTextAndPath(BuildContext context, List<String> list, String text, String path) {
    final int koef = list.length;
    return MaterialButton(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontSize: (144 / koef).toDouble(),
        ),
      ),
      minWidth: (1050 / koef).toDouble(),
      height: (450 / koef).toDouble(),
      textColor: Colors.black54,
      color: Color.fromRGBO(255, 249, 230, 1),
      onPressed: () {
        switch (path) {
          case '/table_results':
            break;
          case '/person':
            CurrentUser.person = Person.personByFio(text);
            break;
        }
        Navigator.pushNamed(context, path);
      },
    );
  }

  // static Widget btnsByActivity({required BuildContext context, Activity? activity, required List<Activity> srcActivity}) {
  //   List<Activity>? childrenActivities;
  //   if (activity == null) {
  //     childrenActivities = HierarchEntityUtil<Activity>().getTopData(srcActivity);
  //   } else {
  //     childrenActivities = HierarchEntityUtil<Activity>().getChildrenData(activity, srcActivity);
  //   }
  //   if (childrenActivities == null || childrenActivities.isEmpty) {
  //     return BoardPage();
  //   }
  //   final int koef = childrenActivities.length;
  //   List<MaterialButton> childrenBtn = childrenActivities.map((act) => MaterialButton(
  //     child: Text(
  //       act.name,
  //       textAlign: TextAlign.center,
  //       style: new TextStyle(
  //         fontSize: (144 / koef).toDouble(),
  //       ),
  //     ),
  //     minWidth: (1050 / koef).toDouble(),
  //     height: (450 / koef).toDouble(),
  //     textColor: Colors.black54,
  //     color: Color.fromRGBO(255, 249, 230, 1),
  //     onPressed: () => btnsByActivity(context: context, activity: act, srcActivity: srcActivity),
  //   )
  //   ).toList();
  //   Widget widget = Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children:
  //     <Widget>[
  //       Card(
  //         child:
  //           IconButton(
  //             onPressed: null,
  //             icon: Icon(
  //               Icons.person,
  //               color: Colors.green,
  //               size: 30.0,
  //             ),
  //             alignment: Alignment.topLeft,
  //           ),
  //       ),
  //       Padding(padding: EdgeInsets.all(10)),
  //       ...childrenBtn,
  //       Padding(padding: EdgeInsets.all(10)),
  //     ],
  //   );
  //   return widget;
  // }

  static final ButtonStyle mainMenuButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 249, 230, 1)),
    foregroundColor: MaterialStateProperty.all(Colors.black54),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    )),
    fixedSize: MaterialStateProperty.all(Size(300, 300)),
  );

  static final ButtonStyle subMenuButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 249, 230, 1)),
    foregroundColor: MaterialStateProperty.all(Colors.black54),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    )),
  );

}

// class ScoreMainMenuButton extends OutlinedButton {
//
//   const ScoreMainMenuButton({
//     Key? key,
//     required VoidCallback? onPressed,
//     VoidCallback? onLongPress,
//     ButtonStyle? style = const ButtonStyle(
//       backgroundColor: const MaterialStateProperty.resolveWith<Color?>(Color.fromRGBO(255, 249, 230, 1)),
//       foregroundColor: MaterialStateProperty.all(Colors.black54),
//       shape: MaterialStateProperty.all(painting.RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(18.0),
//       )),
//       ),
//     FocusNode? focusNode,
//     bool autofocus = false,
//     Clip clipBehavior = Clip.none,
//     required Widget child,
//   }) : super(
//     key: key,
//     onPressed: onPressed,
//     onLongPress: onLongPress,
//     style : style,
//     focusNode: focusNode,
//     autofocus: autofocus,
//     clipBehavior: clipBehavior,
//     child: child,
//   );
// }
//
// class BallCard extends Card (
//   shape:
//     RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(18.0),
//     )
// );