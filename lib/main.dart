import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loggy/loggy.dart';
import 'package:score_system/screen/activity_choose_screen.dart';
import 'package:score_system/screen/encyclopedia_screen.dart';
import 'package:score_system/screen/main_menu_screen.dart';
import 'package:score_system/screen/participant_add_tasks_screen.dart';
import 'package:score_system/screen/participant_tasks_screen.dart';
import 'package:score_system/screen/participants_prize_screen.dart';
import 'package:score_system/screen/participants_screen.dart';
import 'package:score_system/screen/wiki/aims_screen.dart';
import 'package:score_system/screen/wiki/annual_practice_screen.dart';
import 'package:score_system/screen/wiki/errors_screen.dart';
import 'package:score_system/screen/wiki/how_pause_screen.dart';
import 'package:score_system/screen/wiki/how_use_screen.dart';
import 'package:score_system/screen/wiki/long_results_screen.dart';
import 'package:score_system/screen/wiki/resistance_screen.dart';
import 'package:score_system/screen/wiki/wiki_screen.dart';
import 'package:score_system/vocabulary/activity_data.dart';
import 'package:score_system/vocabulary/constant.dart';
import 'package:score_system/vocabulary/person_data.dart';
import 'current_data.dart';
import 'locator.dart';
import 'model/person.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  Loggy.initLoggy();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  setup();
  runApp(
    AppStartWidget()
  );
}

void setup() {
  // initialize date formating
  initializeDateFormatting();
  setupLocator();
}

class AppStartWidget extends StatelessWidget {

  Person? _person;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (_person == null) {
      List<Person> persons = locator<PersonData>().getData();
      _person = persons.isEmpty ? null : persons.first;
    }
    if (CURRENT_USER == null) {
      CURRENT_USER = _person;
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
              title: AppLocalizations.of(context)!.appTitle,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en', ''), // English, no country code
                Locale('ru', ''), // Russian, no country code
              ],
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
                iconTheme: IconThemeData(color: Color.fromRGBO(245, 209, 121, 1)),
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
                    btnTitleMap: Map.fromIterable(locator<PersonData>().getData(), key: (person) => person.fio(), value: (person) => '/person')
                ),
                ParticipantsPage.ROUTE_NAME: (context) => ParticipantsPage(),
                ParticipantTasksPage.ROUTE_NAME: (context) => ParticipantTasksPage(),
                ParticipantPrizePage.ROUTE_NAME: (context) => ParticipantPrizePage(),
                EncyclopediaPage.ROUTE_NAME: (context) => EncyclopediaPage(),
                AddParticipantTasksPage.ROUTE_NAME: (context) =>
                  AddParticipantTasksPage(
                    context,
                    _person,
                    locator<ActivityData>().getData()
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
                ActivityChoosePage.ROUTE_NAME: (context) => ActivityChoosePage(context, null, locator<ActivityData>().getData()),
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
              ? Image.asset('${IMG_PATH}intro.png')
              : Image.asset('${IMG_PATH}intro_dark.png')),
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