import '../model/entity.dart';

abstract class SearchContract {
  Future<CategoryEntityResult> search(String term);
}