import 'package:score_system/vocabulary/constant.dart';
import 'package:tuple/tuple.dart';

class BaseEntity {
  late int id;
  String? name;
  String? desc;

  BaseEntity({required this.id, this.name, this.desc});

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "name" : name,
      "desc" : desc,
    };
  }

  BaseEntity.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['fio'];
    this.desc = obj['desc'];
  }

}

class HierarchEntity extends BaseEntity {
  late int status;
  String? parentIdList;

  HierarchEntity({required int id, String? name, String? desc, String? parentIdList, int status = 0}) :
        this.status = status,
        this.parentIdList = parentIdList,
        super(id: id, name: name, desc: desc);


  Map<String,dynamic> toMap() {
    return <String,dynamic>{
      "id" : id,
      "name" : name,
      "parentIdList" : parentIdList,
      "status" : status,
      "desc" : desc,
    };
  }

  Map<String,dynamic> toMapNoId() { // used when inserting data to the database
    Map<String,dynamic> map = toMap();
    map.remove("id");
    return map;
  }

  HierarchEntity.fromMap(dynamic obj) : super.fromMap(obj) {
    this.status = obj['status'];
    this.parentIdList = obj['parentIdList'];
  }

  static HierarchEntity getDummy() => HierarchEntity(id: 0, name: 'Dummy');

  static List<Tuple2<T, List<T>>> getTopDataWithChildren <T extends HierarchEntity> (List<T> srcList, String searchString) {
    String searchStr = searchString.toLowerCase();
    List<T> categories = srcList
        .where((element) => (element.parentIdList == null || element.parentIdList!.isEmpty))
        .toList();
    return categories
        .map((category) {
          List<T> children = srcList
              .where((element) => (element.parentIdList != null && element.parentIdList!.split(STRING_DELIMETER).map((e) => int.parse(e)).contains(category.id))
              && (searchStr.isEmpty ? true : element.name!.toLowerCase().contains(searchStr))
          )
              .toList();
          return Tuple2(category, children);
      }
      )
      .toList();
  }

}

class HierarchEntityUtil<T extends HierarchEntity> {

  List<T> getTopData(List<T> srcList) {
    return srcList.where((element) => element.parentIdList == null || element.parentIdList!.isEmpty).toList();
  }

  List<T> getChildrenData(T entity, List<T> srcList) {
    return srcList.where((element) => element.parentIdList != null && element.parentIdList!.split(STRING_DELIMETER).map((e) => int.parse(e)).contains(entity.id)).toList();
  }

}
