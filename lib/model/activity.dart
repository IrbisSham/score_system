import '../vocabulary/constant.dart';
import 'entity.dart';

class Activity extends HierarchEntity{
  int sum;
  bool isCategory;
  bool isCategorized;
  String? avaPath;
  Activity({required int id, required String name, String? desc, String? parentIdList, int status = 0, int sum = 0, bool isCategory = false, bool isCategorized = false, String? avaPath}) :
    this.sum = sum,
    this.isCategory = isCategory,
    this.isCategorized = isCategorized,
    this.avaPath = avaPath,
    super(id: id, name: name, desc: desc, parentIdList: parentIdList, status: status);

  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "name" : name,
      "desc" : desc,
      "parentIdList" : parentIdList,
      "status" : status,
      "sum" : sum,
      "isCategory" : isCategory,
      "isCategorized" : isCategorized,
      "avaPath" : avaPath,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Activity
              && runtimeType == other.runtimeType
              && id == other.id
              && name == other.name
              && desc == other.desc
              && parentIdList == other.parentIdList
              && status == other.status
              && sum == other.sum
              && isCategory == other.isCategory
              && isCategorized == other.isCategorized
              && avaPath == other.avaPath;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + name.hashCode;
    result = 37 * result + desc.hashCode;
    result = 37 * result + parentIdList.hashCode;
    result = 37 * result + status.hashCode;
    result = 37 * result + sum.hashCode;
    result = 37 * result + isCategory.hashCode;
    result = 37 * result + isCategorized.hashCode;
    result = 37 * result + avaPath.hashCode;
    return result;
  }

}

Activity ACTIVITY_DUMMY = Activity(id: 0, name: DUMMY);

