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

  Map<String,dynamic> toMapNoId() { // used when inserting data to the database
    Map<String,dynamic> map = toMap();
    map.remove("id");
    return map;
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

  HierarchEntity.fromMap(dynamic obj) : super.fromMap(obj) {
    this.status = obj['status'];
    this.parentIdList = obj['parentIdList'];
  }

  static Future<List<Tuple2<T, List<T>>>> getTopDataWithChildrenByWord <T extends HierarchEntity> (List<Tuple2<T, List<T>>> srcList, String searchString) async {
    String searchStr = searchString.toLowerCase();
    return srcList
        .map((parentWithChildren) {
          T parent = parentWithChildren.item1;
          List<T> children = parentWithChildren.item2.where((child) => searchStr.isEmpty ? true : child.name!.toLowerCase().contains(searchStr)).toList();
          return Tuple2(parent, children);
        })
        .toList();
  }

  static Future<List<Tuple2<T, List<T>>>> getTopDataWithChildren <T extends HierarchEntity> (List<T> srcList) async {
    List<T> categories = srcList
        .where((element) => (element.parentIdList == null || element.parentIdList!.isEmpty))
        .toList();
    return categories
        .map((category) {
          List<T> children = srcList
              .where((element) => (element.parentIdList != null && element.parentIdList!.split(STRING_DELIMETER).map((e) => int.parse(e)).contains(category.id))
          )
              .toList();
          return Tuple2(category, children);
        }
        )
      .toList();
  }

}

class HierarchEntityUtil<T extends HierarchEntity> {

  Future<List<T>> getTopData(List<T> srcList) async {
    return srcList.where((element) => element.parentIdList == null || element.parentIdList!.isEmpty).toList();
  }

  Future<List<T>> getChildrenData(T entity, List<T> srcList) async {
    return srcList.where((element) => element.parentIdList != null && element.parentIdList!.split(STRING_DELIMETER).map((e) => int.parse(e)).contains(entity.id)).toList();
  }

}

typedef CategoryEntities = Tuple2<HierarchEntity, List<HierarchEntity>>;

class CategoryEntityResult {
  final List<CategoryEntities> items;

  CategoryEntityResult(this.items);

  bool get isPopulated => items.isNotEmpty;

  bool get isEmpty => items.isEmpty;
}