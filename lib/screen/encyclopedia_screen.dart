import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:score_system/vocabulary/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class EncyclopediaPage extends StatelessWidget {
  
  static final String ROUTE_NAME = '/encyclopedia';
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .secondary,
          title: Container(
            alignment: Alignment.center,
            child: Text(
              'EncyclopediaPage.ScreenTitle'.tr(),
              style:
              TextStyle(fontSize: 24,
                color: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
              ),
            ),
          ),
        ),
        bottomNavigationBar: MainBottomNavigationBar(context, _selectedIndex),
        body:
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child:
              Text(
                  'EncyclopediaPage.Theme'.tr(),
                  style: TextStyle(fontSize: 24)),
            ),
            Card(
                child:
                Column(
                  children: [
                    ListTile(
                      leading:
                      Icon(
                        Icons.thumb_up_rounded,
                      ),
                      title:
                      Text(
                        'EncyclopediaPage.Punkt1Title'.tr(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'EncyclopediaPage.Punkt1Text'.tr()
                      )
                    ),
                    ListTile(
                      leading:
                        SvgPicture.asset(
                          '${IMG_PATH}target.swg',
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                        ),
                      title:
                        Text(
                          'EncyclopediaPage.Punkt2Title'.tr(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                    ),
                    Flexible(
                      child: Text(
                        'EncyclopediaPage.Punkt2Text'.tr()
                      ),
                    ),
                    ListTile(
                      leading:
                      SvgPicture.asset(
                        '${IMG_PATH}surface1.swg',
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                      title:
                      Text(
                        'EncyclopediaPage.Punkt3Title'.tr(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'EncyclopediaPage.Punkt3Text'.tr()
                      ),
                    ),
                    ListTile(
                      leading:
                      SvgPicture.asset(
                        '${IMG_PATH}finish_line1.swg',
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                      title:
                      Text(
                        'EncyclopediaPage.Punkt4Title'.tr(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'EncyclopediaPage.Punkt4Text'.tr()
                      ),
                    ),
                    ListTile(
                      leading:
                      SvgPicture.asset(
                        '${IMG_PATH}start1.swg',
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                      title:
                      Text(
                        'EncyclopediaPage.Punkt5Title'.tr(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                          'EncyclopediaPage.Punkt5Text'.tr()
                        ),
                    ),
                    ListTile(
                      leading:
                      SvgPicture.asset(
                        '${IMG_PATH}scroll1.swg',
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                      title:
                      Text(
                        'EncyclopediaPage.Punkt6Title'.tr(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'EncyclopediaPage.Punkt6Text'.tr()
                      ),
                    ),
                  ],
                )
            ),
          ],
        )
    );
  }

}