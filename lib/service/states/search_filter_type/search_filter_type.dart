import 'package:flutter/material.dart';

enum SearchFilterType {
  all(value: 'ALL'),
  comics(value: 'COMICS'),
  collections(value: 'COLLECTIONS');

  final String value;
  const SearchFilterType({required this.value});
}

class SearchFilterTypeState {
  static final mode = ValueNotifier<SearchFilterType>(SearchFilterType.all);
}