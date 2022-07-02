List filterList(List list, String searchTerm) {
    return list
        .where((element) => element.toLowerCase().contains(searchTerm))
        .toList();
  }