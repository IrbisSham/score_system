import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_system/model/activity.dart';
import 'package:tuple/tuple.dart';
import '../main.dart';
import '../model/entity.dart';
import '../vocabulary/activity_data.dart';
import 'category_activity_event.dart';
import 'category_activity_state.dart';

class CategoryActivityBloc extends Bloc<CategoryActivityEvent, CategoryActivityState> {

  CategoryActivityBloc(CategoryActivityState initialState) : super(initialState) {
    on<CategoryActivityEvent>((event, emit) => emit(state));
  }

  // CategoryActivityState get initialState => CategoryActivityPresented(
  //     HierarchEntity
  //       .getTopDataWithChildren(locator<ActivityData>().getData())
  // );

  Stream<CategoryActivityState> mapEventToState(CategoryActivityEvent event) async* {
    if (event is SearchWordTyped) {
      yield _mapSearchWordTypedToState(event);
    }
  }

  CategoryActivityState _mapSearchWordTypedToState(SearchWordTyped event) {
    final initList = (state as CategoryActivityPresented).list;
    List<Tuple2<Activity, List<Activity>>> updatedList = [];
    Future.delayed(const Duration(seconds: 1), () {
      updatedList = HierarchEntity
          .getTopDataWithChildrenByWord(initList, event.word);
    });
    return CategoryActivityPresented(updatedList);
  }
}