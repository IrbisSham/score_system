import 'package:score_system/vocabulary/constant.dart';
import 'package:tuple/tuple.dart';

class IndexName {
  final int index;
  final String name;
  IndexName({required this.index, required this.name});
}

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
    this.name = obj['name'];
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

}

class HierarchEntityUtil<T extends HierarchEntity> {

  List<T> getTopData(List<T> srcList) {
    return srcList.where((element) => element.parentIdList == null || element.parentIdList!.isEmpty).toList();
  }

  List<T> getChildrenData(T entity, List<T> srcList) {
    return srcList.where((element) => element.parentIdList != null && element.parentIdList!.split(STRING_DELIMETER).map((e) => int.parse(e)).contains(entity.id)).toList();
  }

  List<Tuple2<T, List<T>>> getTopDataWithChildrenByWord (List<Tuple2<T, List<T>>> srcList, String searchString) {
    String searchStr = searchString.toLowerCase();
    return srcList
        .map((parentWithChildren) {
      T parent = parentWithChildren.item1;
      List<T> children = parentWithChildren.item2.where((child) => searchStr.isEmpty ? true : child.name!.toLowerCase().contains(searchStr)).toList();
      return Tuple2(parent, children);
    })
        .toList();
  }

  List<Tuple2<T, List<T>>> getTopDataWithChildren (List<T> srcList) {
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

typedef CategoryEntities = Tuple2<HierarchEntity, List<HierarchEntity>>;

class CategoryEntityResult {
  final List<CategoryEntities> items;

  CategoryEntityResult(this.items);

  bool get isPopulated => items.isNotEmpty;

  bool get isEmpty => items.isEmpty;
}