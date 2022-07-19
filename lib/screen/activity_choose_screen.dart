import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:score_system/model/activity.dart';
import 'package:score_system/model/entity.dart';
import 'package:score_system/screen/board_screen.dart';

class ActivityChoosePage extends StatefulWidget {

  BuildContext _ctx;
  Activity? _activity;
  final List<Activity> _srcActivity;

  static final String ROUTE_NAME = '/board';

  ActivityChoosePage(this._ctx, this._activity, this._srcActivity);

  @override
  _ActivityChoosePageState createState() => _ActivityChoosePageState();
}

class _ActivityChoosePageState extends State<ActivityChoosePage> {

  Widget btnsByActivity({required BuildContext context, Activity? activity, required List<Activity> srcActivity}) {
    List<Activity>? childrenActivities;
    if (activity == null) {
      childrenActivities = HierarchEntityUtil<Activity>().getTopData(srcActivity);
    } else {
      childrenActivities = HierarchEntityUtil<Activity>().getChildrenData(activity, srcActivity);
    }
    if (childrenActivities.isEmpty) {
      return BoardPage(activity!);
    }
    childrenActivities.add(Activity(id: -1, name: '+ Зона'));
    Column gridWithOuter =
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 130,
                child:
                  SingleChildScrollView(
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                            childAspectRatio: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                        itemCount: childrenActivities.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                              onTap: (){
                                setState(() {
                                  this.widget._activity = childrenActivities![index];
                                  this.widget._ctx = context;
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child:
                                  SingleChildScrollView(
                                    child: index == childrenActivities!.length - 1 ?
                                    Container(
                                      alignment: Alignment.center,
                                      height: 130,
                                      width: MediaQuery.of(context).size.width / 2,
                                      padding: EdgeInsets.only(bottom: 30),
                                      child : FittedBox(
                                        fit: BoxFit.fill,
                                        child: Text(
                                          childrenActivities[index].name!,
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
                                    )
                                        : Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.primaries[index],
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.25,
                                                  height: 30,
                                                  padding: EdgeInsets.only(left: 10),
                                                  child:
                                                  FittedBox(
                                                    fit: BoxFit.fill,
                                                    child: Text(
                                                      childrenActivities[index].name!,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  // width: MediaQuery.of(context).size.width * 0.5,
                                                  // padding: EdgeInsets.only(right: 10),
                                                  child:
                                                  Container(
                                                    height: 20,
                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      // borderRadius: BorderRadius.circular(10),
                                                      // border: Border(
                                                      //   top: BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
                                                      //   bottom: BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
                                                      //   left: BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
                                                      //   right: BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
                                                      // ),
                                                    ),
                                                    child:
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.08,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            shape: BoxShape.rectangle,
                                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                                            border: Border.all(
                                                                color: Colors.white, width: 2, style: BorderStyle.solid
                                                            ),
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   width: MediaQuery.of(context).size.width * 0.02,
                                                        //   height: 20,
                                                        //   decoration: BoxDecoration(
                                                        //     color: Colors.white,
                                                        //   ),
                                                        // ),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.07,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            shape: BoxShape.rectangle,
                                                            border: Border(
                                                              top: BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
                                                              bottom: BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
                                                            ),
                                                          ),
                                                        ),
                                                        // Container(
                                                        //   width: MediaQuery.of(context).size.width * 0.02,
                                                        //   height: 20,
                                                        //   decoration: BoxDecoration(
                                                        //     color: Colors.white,
                                                        //   ),
                                                        // ),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.03,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            shape: BoxShape.rectangle,
                                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                            border: Border.all(
                                                                color: Colors.white, width: 2, style: BorderStyle.solid
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        Container(
                                          height: 100,
                                          width: MediaQuery.of(context).size.width / 2,
                                          decoration: BoxDecoration(
                                            color: Colors.accents[index],
                                          ),
                                          child: Image.network("https://source.unsplash.com/random/300x200?v=${DateTime.now().millisecondsSinceEpoch}",
                                              fit: BoxFit.cover),
                                        ),
                                      ],
                                    ),
                                  )
                              )
                          );
                        }),
                  ),
              ),
              Container(
                height: 50,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[800],
                ),
                child:
                  SingleChildScrollView(
                    child:
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: EdgeInsets.only(left: 20),
                            child:
                              Row(
                                children: [
                                  IconButton(onPressed: null, icon: Icon(Icons.check_box, color: Colors.white)),
                                  Text("|", style: TextStyle(fontSize: 36, color: Colors.white),),
                                  IconButton(onPressed: null, icon: Icon(Icons.list, color: Colors.white)),
                                ],
                              ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: IconButton(onPressed: null, icon: Icon(Icons.settings, color: Colors.white)),
                              ),
                          ),

                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width / 3,
                          //   child: Container(
                          //     alignment: Alignment.centerRight,
                          //     child: IconButton(onPressed: null, icon: Icon(Icons.settings, color: Colors.white)),
                          //   ),
                          // ),
                        ],
                      ),
                  ),
              ),
            ],
          );
    Widget widget = Scaffold(
      appBar: AppBar(
        title: Text('Зоны'),
        actions: <Widget>[
          Container(
            width: 90,
            height: 30,
            child: Row(
              children: [
                FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                    "Лизок",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon:Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    // do something
                  },
                )
              ],
            ),
          )
        ],
      ),
      body: gridWithOuter,
    );
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return btnsByActivity(context: widget._ctx, activity: widget._activity, srcActivity: widget._srcActivity);
  }

}
