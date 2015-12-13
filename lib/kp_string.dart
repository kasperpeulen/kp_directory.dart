String kebab2camel(String string) {
  final pattern = '-';
  var list = string.split(pattern).toList();
  list = list.map((e) => capitalize(e));
  return deCapitalize(list.join(''));
}

String capitalize(String string) {
  return '${string[0].toUpperCase()}${string.substring(1)}';
}

String deCapitalize(String string) {
  return '${string[0].toLowerCase()}${string.substring(1)}';
}
