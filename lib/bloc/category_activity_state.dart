import 'package:tuple/tuple.dart';
import '../model/activity.dart';

abstract class CategoryActivityState {}

class CategoryActivityPresented extends CategoryActivityState {

  final List<Tuple2<Activity, List<Activity>>> list;

  CategoryActivityPresented(this.list);

}