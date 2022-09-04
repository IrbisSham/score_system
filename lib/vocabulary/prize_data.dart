import 'package:score_system/model/activity.dart';
import 'package:score_system/model/prize.dart';
import 'package:score_system/vocabulary/abstract_list_voc.dart';
import 'package:score_system/vocabulary/constant.dart';

class PrizeData extends EntitiesData<Prize>{

  PrizeData() : super(isDbMode: IS_DB_MODE);

  List<Prize> _localData = [
    Prize(
      id: 1,
      name: 'Мороженка',
      sum: 2,
    ),
    Prize(
      id: 2,
      name: 'Настольная игра с папой',
      sum: 5,
    ),
    Prize(
      id: 3,
      name: 'Поход',
      sum: 20,
    ),
  ];

  @override
  List<Prize> getLocalData() {
    return _localData;
  }

  @override
  void _setLocalData(List<Prize> data){
    _localData = data;
  }

  @override
  String getTableName() {
    return "Prize";
  }

  @override
  List<String> getColumnNames() {
    return ["id", "name", "status", "desc", "sum"];
  }

  @override
  Prize dbDataToEntity(Map<String, Object?> map) {
    return Prize(
      id: map['id'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String,
      sum: map['sum'] as int,
    );
  }

}