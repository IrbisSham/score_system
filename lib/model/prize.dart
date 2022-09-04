import '../vocabulary/constant.dart';
import 'entity.dart';

class Prize extends BaseEntity {
  int sum;
  Prize({required int id, required String name, String? desc, int sum = 0}) :
  this.sum = sum,
  super(id: id, name: name, desc: desc);

  Map<String,dynamic> toMap() { // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "name" : name,
      "desc" : desc,
      "sum" : sum,
    };
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Prize
    && runtimeType == other.runtimeType
    && id == other.id
    && name == other.name
    && desc == other.desc
    && sum == other.sum;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + name.hashCode;
    result = 37 * result + desc.hashCode;
    result = 37 * result + sum.hashCode;
    return result;
  }

}

Prize PRIZE_DUMMY = Prize(id: 0, name: DUMMY);
