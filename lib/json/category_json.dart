class Category {
  final String emoticon, name;

  Category({required this.emoticon, required this.name});
}

List<Category> categories = [
  Category(
      emoticon: '😍',
      name: 'Romance'),
  Category(
      emoticon: '😂',
      name: 'Comedy'),
  Category(
      emoticon:
          '😱',
      name: 'Horror'),
  Category(emoticon: '😚', name: 'Drama')
];
