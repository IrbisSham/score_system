import 'package:score_system/model/activity.dart';
import 'package:score_system/vocabulary/abstract_list_voc.dart';
import 'package:score_system/vocabulary/constant.dart';

class ActivityData extends EntitiesData<Activity>{

  ActivityData() : super(isDbMode: IS_DB_MODE);

  List<Activity> _localData = [
    Activity(
      id: 1,
      name: 'Детская',
      isCategory: true,
      isCategorized: true,
    ),
    Activity(
      id: 2,
      name: 'Гостиная',
      isCategory: true,
      isCategorized: true,
    ),
    Activity(
      id: 3,
      name: 'Кухня',
      isCategory: true,
      isCategorized: true,
    ),
    Activity(
      id: 4,
      name: 'Ежедневная рутина',
      isCategory: true,
      isCategorized: true,
      parentIdList: '1,2,3',
    ),
    Activity(
      id: 5,
      name: 'Генеральная уборка',
      isCategory: true,
      isCategorized: true,
      parentIdList: '1',
      image: ACT_PATH + 'cleaning_general.png',
      sum: 30,
    ),
    Activity(
      id: 6,
      name: 'Спальное место',
      isCategory: true,
      isCategorized: true,
      parentIdList: '4',
      sum: 3,
    ),
    Activity(
      id: 7,
      name: 'Рабочее место',
      isCategory: true,
      isCategorized: true,
      parentIdList: '4',
      sum: 5,
    ),
    Activity(
      id: 8,
      name: 'Шкаф',
      isCategory: true,
      isCategorized: true,
      parentIdList: '1,2,3',
      sum: 10,
    ),
    Activity(
      id: 9,
      name: 'Комод',
      isCategory: true,
      isCategorized: true,
      parentIdList: '1,2',
      sum: 8,
    ),
    Activity(
      id: 10,
      name: 'Пол',
      isCategory: true,
      isCategorized: true,
      parentIdList: '1,2,3',
    ),
    Activity(
      id: 11,
      isCategory: true,
      isCategorized: true,
      name: 'Гигиена',
    ),
    Activity(
      id: 12,
      isCategorized: true,
      name: 'Зубы',
      parentIdList: '11',
      sum: 1,
    ),
    Activity(
      id: 13,
      isCategorized: true,
      name: 'Подмывание',
      parentIdList: '11',
      sum: 2,
    ),
    Activity(
      id: 14,
      name: 'Сделать зарядку',
      sum: 2,
      image: ACT_PATH + 'gym.png',
    ),
    Activity(
      id: 15,
      name: 'Протереть мебель',
      image: ACT_PATH + 'dusting_furniture.png',
      sum: 2,
    ),
    Activity(
      id: 16,
      name: 'Глажка',
      image: ACT_PATH + 'ironing.png',
      sum: 2,
    ),
    Activity(
      id: 17,
      name: 'Заправить кровать',
      image: ACT_PATH + 'bed_make.png',
      sum: 2,
    ),
    Activity(
      id: 18,
      name: 'Вынести мусор',
      image: ACT_PATH + 'garbage_out.png',
      sum: 2,
    ),
    Activity(
      id: 19,
      name: 'Приготовить еду',
      image: ACT_PATH + 'cooking.png',
      sum: 2,
    ),
    Activity(
      id: 20,
      name: 'Пропылесосить',
      image: ACT_PATH + 'vacuum_cleaning.png',
      sum: 2,
    ),
    Activity(
      id: 21,
      name: 'Почистить обувь',
      image: ACT_PATH + 'shine_shoes.png',
      sum: 2,
    ),
    Activity(
      id: 22,
      name: 'Убрать за животным',
      image: ACT_PATH + 'animal_clean.png',
      sum: 2,
    ),
    Activity(
      id: 23,
      name: 'Почистить одежду',
      image: ACT_PATH + 'clean_clothers.png',
      sum: 2,
    ),
    Activity(
      id: 24,
      name: 'Вымыть окна',
      image: ACT_PATH + 'clean_windows.png',
      sum: 2,
    ),
    Activity(
      id: 25,
      name: 'Высушить одежду',
      image: ACT_PATH + 'cloth_drying.png',
      sum: 2,
    ),
    Activity(
      id: 26,
      name: 'Постирать одежду',
      image: ACT_PATH + 'cloth_washing.png',
      sum: 2,
    ),
    Activity(
      id: 27,
      name: 'Вымыть посуду',
      image: ACT_PATH + 'dish_washing.png',
      sum: 2,
    ),
    Activity(
      id: 28,
      name: 'Вымыть пол',
      image: ACT_PATH + 'floor_washing.png',
      sum: 2,
    ),
    Activity(
      id: 29,
      name: 'Протереть пыль',
      image: ACT_PATH + 'dusting_subjects.png',
      sum: 2,
    ),
    Activity(
      id: 30,
      name: 'Полить растения',
      image: ACT_PATH + 'plant_watering.png',
      sum: 2,
    ),
    Activity(
      id: 31,
      name: 'Подстричься',
      image: ACT_PATH + 'hairdressing.png',
      sum: 2,
    ),
    Activity(
      id: 32,
      name: 'Распрыскать',
      image: ACT_PATH + 'spraying.png',
      sum: 2,
    ),
    Activity(
      id: 33,
      name: 'Подмести',
      image: ACT_PATH + 'sweeping.png',
      sum: 2,
    ),
    Activity(
      id: 34,
      name: 'Накрыть на стол',
      image: ACT_PATH + 'table_prepare_eating.png',
      sum: 2,
    ),
    Activity(
      id: 35,
      name: 'Принять ванну',
      image: ACT_PATH + 'take_bath.png',
      sum: 2,
    ),
    Activity(
      id: 36,
      name: 'Пропылесосить',
      image: ACT_PATH + 'vacuum_cleaning.png',
      sum: 2,
    ),
    Activity(
      id: 37,
      name: 'Прочистить канализацию',
      image: ACT_PATH + 'vantuz.png',
      sum: 2,
    ),
    Activity(
      id: 38,
      name: 'Вымыть животное',
      image: ACT_PATH + 'wash_animal.png',
      sum: 2,
    ),
    Activity(
      id: 39,
      name: 'Помыть фасад дома',
      image: ACT_PATH + 'wash_house.png',
      sum: 2,
    ),
    Activity(
      id: 40,
      name: 'Помыть стекла',
      image: ACT_PATH + 'glass_clean.png',
      sum: 2,
    ),
  ];

  @override
  List<Activity> getLocalData() {
    return _localData;
  }

  @override
  String getTableName() {
    return "Activity";
  }

  @override
  List<String> getColumnNames() {
    return ["id", "name", "status", "desc", "parentIdList", "sum" , "isCategory", "isCategorized", "avaPath"];
  }

  @override
  Activity dbDataToEntity(Map<String, Object?> map) {
    return Activity(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as int,
      desc: map['desc'] as String,
      parentIdList: map['parentIdList'] as String,
      sum: map['sum'] as int,
      isCategory: map['isCategory'] as bool,
      isCategorized: map['isCategorized'] as bool,
      image: map['avaPath'] as String,
    );
  }

}