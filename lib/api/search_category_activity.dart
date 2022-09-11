import 'package:score_system/api/search_contract.dart';
import 'package:tuple/tuple.dart';

import '../locator.dart';
import '../model/activity.dart';
import '../model/entity.dart';
import '../vocabulary/activity_data.dart';

// typedef CategoryActivities = Tuple2<Activity, List<Activity>>;

// class CategoryActivityResult {
//   List<CategoryActivities> items;
//   CategoryActivityResult(this.items);
//   bool get isPopulated => items.isNotEmpty;
//   bool get isEmpty => items.isEmpty;
// }

class CategoryActivityApi implements SearchContract {
  final Map<String, CategoryEntityResult> cache;
  CategoryActivityApi({
    Map<String, CategoryEntityResult>? cache,
  }): cache = cache ?? <String, CategoryEntityResult>{};

  @override
  Future<CategoryEntityResult> search(String term) async {
    if (cache.containsKey(term)) {
      return cache[term]!;
    } else {
      final result = await _fetchResults(term);
      cache[term] = result;
      return result;
    }
  }

  Future<CategoryEntityResult> _fetchResults(String term) async {
    List<Activity> srcList = locator<ActivityData>().getData();
    List<Tuple2<HierarchEntity, List<HierarchEntity>>> categoryActivities = locator<HierarchEntityUtil>().getTopDataWithChildren(srcList);
    List<Tuple2<HierarchEntity, List<HierarchEntity>>> categoryActivitiesByTerm = locator<HierarchEntityUtil>().getTopDataWithChildrenByWord(categoryActivities, term);
    return CategoryEntityResult(categoryActivitiesByTerm);
  }
}