import 'package:rxdart/rxdart.dart';
import '../api/search_category_activity.dart';
import 'category_activity_state.dart';

class CategoryActivityBloc {
  factory CategoryActivityBloc(CategoryActivityApi api) {
    // If used behavior subject, it shows the previous result
    final onTextChanged = PublishSubject<String>();

    final state = onTextChanged
    // If the text has not changed, do not perform a new search
        .distinct()
    // Wait for the user to stop typing for 500ms before running a search
        .debounceTime(const Duration(milliseconds: 500))
    // Call the Github api with the given search term.
    // If another search term is entered, switchMap will ensure
    // the previous search is discarded
        .switchMap<CategoryActivityState>((String term) => _helpers!.eventTyping(term))
    // The initial state to deliver to the screen.
        .startWith(CategoryActivityNoTerm());

    return CategoryActivityBloc._(api, onTextChanged, state);
  }

  /// Sink exposed to UI
  final Sink<String> onTextChanged;

  /// State exposed to UI
  final Stream<CategoryActivityState> state;

  CategoryActivityBloc._(this.api, this.onTextChanged, this.state)
      : super() {
    _helpers = _Internals(api);
  }

  final CategoryActivityApi api;

  void dispose() {
    onTextChanged.close();
  }

  // INTERNALS
  static _Internals? _helpers;
}

class _Internals {
  _Internals(this.api);

  final CategoryActivityApi api;

  Stream<CategoryActivityState> eventTyping(String term) async* {
    if (term.isEmpty) {
      yield CategoryActivityEmpty();
    } else {
      yield* Rx.fromCallable(() => api.search(term))
          .map((result) =>
      result.isEmpty ? CategoryActivityEmpty() : CategoryActivityPopulated(result as CategoryActivityResult))
          .startWith(CategoryActivityLoading())
          .onErrorReturn(CategoryActivityError());
    }
  }
}