import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:score_system/data/dbprovider.dart';
import 'package:score_system/model/activity.dart';
import 'package:score_system/screen/activity_choose_screen.dart';
import 'package:score_system/screen/main_menu_screen.dart';
import 'package:score_system/screen/participant_add_tasks_screen.dart';
import 'package:score_system/screen/participant_tasks_screen.dart';
import 'package:score_system/screen/participants_screen.dart';
import 'package:score_system/screen/wiki/aims_screen.dart';
import 'package:score_system/screen/wiki/annual_practice_screen.dart';
import 'package:score_system/screen/wiki/errors_screen.dart';
import 'package:score_system/screen/wiki/how_pause_screen.dart';
import 'package:score_system/screen/wiki/how_use_screen.dart';
import 'package:score_system/screen/wiki/long_results_screen.dart';
import 'package:score_system/screen/wiki/resistance_screen.dart';
import 'package:score_system/screen/wiki/wiki_screen.dart';
import 'package:score_system/service/person_service.dart';
import 'package:score_system/util/date_util.dart';
import 'package:score_system/vocabulary/activity_data.dart';
import 'package:score_system/vocabulary/person_data.dart';
import 'package:loggy/loggy.dart';
import 'package:score_system/vocabulary/task_data.dart';

import 'model/entity.dart';
import 'model/person.dart';

GetIt getIt = GetIt.instance;

void main() {
  Loggy.initLoggy();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  setup();
  runApp(const MyApp());
}

void setup() {
  // initialize date formating
  initializeDateFormatting();
  /**
   * Register beans
   */
  getIt.registerSingleton<PersonService>(PersonService());
  getIt.registerSingleton<DateUtil>(DateUtil());
  getIt.registerSingleton<ScoreSystemDbProvider>(ScoreSystemDbProvider());
  getIt.registerSingleton<ActivityData>(ActivityData());
  getIt.registerSingleton<PersonData>(PersonData());
  getIt.registerSingleton<TaskPlanData>(TaskPlanData());
  getIt.registerSingleton<TaskFactData>(TaskFactData());
  getIt.registerSingleton<HierarchEntityUtil>(HierarchEntityUtil());
}

class MyApp extends StatelessWidget {

  Person? _person;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (_person == null) {
      List<Person> persons = getIt<PersonData>().getData();
      _person = persons.isEmpty ? null : persons.first;
    }
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const MaterialApp(home: Splash());
        // } else {
          // Loading is done, return the app:
          return MaterialApp(
              title: 'Бальная система',
              theme: ThemeData(
                // Define the default brightness and colors.
                brightness: Brightness.light,
                primaryColor: Color.fromRGBO(245, 209, 121, 1),
                primaryColorLight: Color.fromRGBO(245, 209, 121, 1),
                primaryColorDark: Color.fromRGBO(245, 209, 121, 1),
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: Color.fromRGBO(245, 209, 121, 1),
                  secondary: Color.fromRGBO(41, 108, 56, 1), // Your accent color
                ),
                scaffoldBackgroundColor: Colors.white,
                // Define the default font family.
                fontFamily: 'SfPro',
                // Define the default TextTheme. Use this to specify the default
                // text styling for headlines, titles, bodies of text, and more.
                textTheme: TextTheme(
                  headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                ),
                cardTheme: CardTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )
                ),
                // canvasColor: Colors.red,
                // shadowColor: Colors.red,
                bottomAppBarColor: Colors.red,
                // cardColor: Colors.red,
                dividerColor: Colors.red,
                buttonColor: Colors.white,
                buttonTheme: ButtonThemeData(
                  buttonColor: Colors.red,
                  focusColor: Colors.red,
                  hoverColor: Colors.red,
                  highlightColor: Colors.red,
                  splashColor: Colors.red,
                  // textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),),
                ),
                // buttonTheme: ButtonThemeData(
                //   buttonColor: Colors.orange, // Background color (orange in my case).
                //   textTheme: ButtonTextTheme.accent,
                //   colorScheme:
                //   Theme.of(context).colorScheme.copyWith(secondary: Colors.green), // Text color
                // ),
              ),
              // Provide a function to handle named routes.
              // Use this function to identify the named
              // route being pushed, and create the correct
              // Screen.
              // onGenerateRoute: (settings) {
              //   // If you push the PassArguments route
              //   switch(settings.name) {
              //     case MainMenuPage.routeName: {
              //       // Cast the arguments to the correct
              //       // type: ScreenArguments.
              //       final args = settings.arguments as ScreenArguments;
              //
              //       // Then, extract the required data from
              //       // the arguments and pass the data to the
              //       // correct screen.
              //       return MaterialPageRoute(
              //         builder: (context) {
              //           return MainMenuPage(
              //             title: args.title,
              //             btnTitleMap: args.btnTitleMap,
              //           );
              //         },
              //       );
              //     }
              //     }
              //   },
              // home: MainMenuPage(
              //     title: 'Бальная система',
              //     btnTitleMap: {
              //       'wiki' : 'База \n знаний',
              //       'table_results' : 'Таблица \n успехов',
              //       'results_month': 'Результаты \n за \n месяц',
              //     }
              // ),
              initialRoute: AddParticipantTasksPage.ROUTE_NAME,
              routes: {
                '/choose_user': (context) => MainMenuPage(
                    title: 'Выберите трудягу',
                    btnTitleMap: Map.fromIterable(getIt<PersonData>().getData(), key: (person) => person.fio(), value: (person) => '/person')
                ),
                ParticipantsPage.ROUTE_NAME: (context) => ParticipantsPage(),
                ParticipantTasksPage.ROUTE_NAME: (context) => ParticipantTasksPage(),
                AddParticipantTasksPage.ROUTE_NAME: (context) =>
                  AddParticipantTasksPage(
                    context,
                    _person,
                    getIt<ActivityData>().getData()
                  ),
                '/person': (context) => MainMenuPage(
                    title: 'Бальная система',
                    btnTitleMap: {
                      'Зоны' : '/board',
                      'Дневник \n успехов' : '/board',
                      'Результаты' : '/results_month',
                      'База \n знаний' : '/wiki',
                    }),
                '/wiki': (context) => WikiPage(),
                '/wiki/annual_practice': (context) => WikiAnnualPracticePage(),
                '/wiki/how_use': (context) => WikiHowUsePracticePage(),
                '/wiki/aims': (context) => WikiAimsPage(),
                '/wiki/resistance': (context) => WikiResistancePage(),
                '/wiki/errors': (context) => WikiErrorsPage(),
                '/wiki/how_pause': (context) => WikiHowPausePage(),
                '/wiki/long_results': (context) => WikiLongResultsPage(),
                ActivityChoosePage.ROUTE_NAME: (context) => ActivityChoosePage(context, null, getIt<ActivityData>().getData()),
              }
          );
        }
      // },
    );
  }

}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor:
      lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
      body: Center(
          child: lightMode
              ? Image.asset('asset/img/intro.png')
              : Image.asset('asset/img/intro_dark.png')),
    );
  }
}

class ScreenArguments {
  final String title;
  final Map<String, String> btnTitleMap;

  ScreenArguments(this.title, this.btnTitleMap);
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}