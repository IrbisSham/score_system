import 'package:flutter/foundation.dart';
import '../api/search_category_activity.dart';
import 'bloc_event_state.component.dart';

enum States {
  noTerm,
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

class CategoryActivityNoTerm extends CategoryActivityState {
  CategoryActivityNoTerm() : super(state: States.noTerm);
}

class CategoryActivityError extends CategoryActivityState {
  CategoryActivityError() : super(state: States.error);
}

class CategoryActivityLoading extends CategoryActivityState {
  CategoryActivityLoading() : super(state: States.loading);
}

class CategoryActivityPopulated extends CategoryActivityState {

  final CategoryActivityResult result;

  CategoryActivityPopulated(this.result) : super(state: States.populated);

}

class CategoryActivityEmpty extends CategoryActivityState {
  CategoryActivityEmpty() : super(state: States.empty);
}