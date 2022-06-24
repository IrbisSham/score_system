import 'package:flutter/material.dart';
import 'package:score_system/api/graphics.dart';

class WikiPage extends StatelessWidget {

  static final menuTexts = {
    'Как ввести систему в ежедневную практику': '/wiki/annual_practice',
    'Как правильно пользоваться': '/wiki/how_use',
    'Цели и задачи системы': '/wiki/how_use',
    'Что делать при сопротивлении': '/wiki/resistance',
    'Типичные ошибки': '/wiki/errors',
    'Как сделать паузу в применении системы': '/wiki/how_pause',
    'Долгосрочные результаты': '/wiki/long_results',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('БаллВики'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
          <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            ...menuTexts.entries.map( (entry) => ButtonGen.btnByListAndTextAndPath(context, menuTexts.keys.toList(), entry.key, entry.value)).toList(),
            Padding(padding: EdgeInsets.all(10)),
          ],
        )
      ),
    );
  }
}