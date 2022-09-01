import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_system/screen/menu/bottom_menu.dart';
import 'package:score_system/vocabulary/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EncyclopediaPage extends StatelessWidget {
  
  static final String ROUTE_NAME = '/encyclopedia';
  int _selectedIndex = 0;

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
              AppLocalizations.of(context)!.encyclopediaScreenTitle,
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
                  AppLocalizations.of(context)!.encyclopediaTheme,
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
                        AppLocalizations.of(context)!.encyclopediaPunkt1Title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                          AppLocalizations.of(context)!.encyclopediaPunkt1Text),
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
                        AppLocalizations.of(context)!.encyclopediaPunkt2Title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                          AppLocalizations.of(context)!.encyclopediaPunkt2Text),
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
                        AppLocalizations.of(context)!.encyclopediaPunkt3Title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                          AppLocalizations.of(context)!.encyclopediaPunkt3Text),
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
                        AppLocalizations.of(context)!.encyclopediaPunkt4Title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                          AppLocalizations.of(context)!.encyclopediaPunkt4Text),
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
                        AppLocalizations.of(context)!.encyclopediaPunkt5Title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                          AppLocalizations.of(context)!.encyclopediaPunkt5Text),
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
                        AppLocalizations.of(context)!.encyclopediaPunkt6Title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                          AppLocalizations.of(context)!.encyclopediaPunkt6Text),
                    ),
                  ],
                )
            ),
          ],
        )
    );
  }

}