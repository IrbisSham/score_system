import 'package:flutter/foundation.dart';
import '../api/search_category_activity.dart';
import '../model/entity.dart';
import 'bloc_event_state.component.dart';

enum States {
  init,
  error,
  loading,
  populated,
  empty,
}

@immutable
class CategoryActivityState extends BlocState {

  final States state;

  CategoryActivityState({required this.state});

}

class CategoryActivityError extends CategoryActivityState {
  CategoryActivityError() : super(state: States.error);
}

class CategoryActivityLoading extends CategoryActivityState {
  CategoryActivityLoading() : super(state: States.loading);
}

class CategoryActivityInit extends CategoryActivityState {

  final CategoryEntityResult result;

  CategoryActivityInit(this.result) : super(state: States.init);

}

class CategoryActivityPopulated extends CategoryActivityState {

  final CategoryEntityResult result;

  CategoryActivityPopulated(this.result) : super(state: States.populated);

}

class CategoryActivityEmpty extends CategoryActivityState {
  CategoryActivityEmpty() : super(state: States.empty);
}