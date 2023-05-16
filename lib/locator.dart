import 'package:get_it/get_it.dart';
import 'package:score_system/model/entity.dart';
import 'package:score_system/service/person_service.dart';
import 'package:score_system/util/date_util.dart';
import 'package:score_system/vocabulary/activity_data.dart';
import 'package:score_system/vocabulary/person_data.dart';
import 'package:score_system/vocabulary/person_prize_data.dart';
import 'package:score_system/vocabulary/prize_data.dart';
import 'package:score_system/vocabulary/task_data.dart';

import 'api/search_category_activity.dart';
import 'bloc/category_activity_bloc.dart';
import 'data/dbprovider.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /**
   * Register beans
   */
  locator.registerSingleton<PersonService>(PersonService());
  locator.registerSingleton<DateUtil>(DateUtil());
  locator.registerSingleton<ScoreSystemDbProvider>(ScoreSystemDbProvider());
  locator.registerSingleton<ActivityData>(ActivityData());
  locator.registerSingleton<PersonData>(PersonData());
  locator.registerSingleton<TaskPlanData>(TaskPlanData());
  locator.registerSingleton<TaskFactData>(TaskFactData());
  locator.registerSingleton<PrizeData>(PrizeData());
  locator.registerSingleton<PersonPrizeData>(PersonPrizeData());
  locator.registerSingleton<HierarchEntityUtil>(HierarchEntityUtil());
  locator.registerSingleton<CategoryActivityApi>(CategoryActivityApi());
  CategoryActivityApi categoryActivityApi = locator<CategoryActivityApi>();
  CategoryEntityResult initCategoryEntityResult = await categoryActivityApi.search('');
  locator.registerLazySingleton<CategoryActivityBloc>(() => CategoryActivityBloc(categoryActivityApi, initCategoryEntityResult));
}