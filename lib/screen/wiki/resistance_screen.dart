import 'package:flutter/material.dart';

class WikiResistancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Что делать при сопротивлении'),
      ),
      body: Center(
          child: Row(
            children: [
              Card(
                child: Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,//.horizontal
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,//.horizontal
                      child: Text(
                        "1 Description that is too long in text format(Here Data is coming from API) jdlksaf j klkjjflkdsjfkddfdfsdfds " +
                            "2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d " +
                            "3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs" +
                            "4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad" +
                            "5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds " +
                            "6 Description that is too long in text format(Here Data is coming from API) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf" +
                            "7 Description that is too long in text format(Here Data is coming from API) df dsfdsfdsfdsfds df dsfds fds fsd" +
                            "8 Description that is too long in text format(Here Data is coming from API)" +
                            "9 Description that is too long in text format(Here Data is coming from API)" +
                            "10 Description that is too long in text format(Here Data is coming from API)",
                        style: TextStyle(
                          fontSize: 16.0, color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}