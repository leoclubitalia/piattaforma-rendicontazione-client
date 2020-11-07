extension Searcher<T> on List<T> {


  List<T> getSuggestions(String value) {
    List<T> suggestions = List<T>();
    for ( T element in this ) {
      if ( value != null && value != "" && element.toString().toLowerCase().contains(value.toLowerCase()) ) {
        suggestions.add(element);
      }
    }
    return suggestions;
  }


}