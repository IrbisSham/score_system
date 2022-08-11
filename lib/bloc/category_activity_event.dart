abstract class CategoryActivityEvent {}

class SearchWordTyped extends CategoryActivityEvent {

  final String word;

  SearchWordTyped(this.word);

}