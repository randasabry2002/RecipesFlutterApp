class Recipe {
  final String name;
  final String imageUrl;
  bool isFavorite;

  // Constructor to initialize the recipe
  Recipe({required this.name, required this.imageUrl, this.isFavorite = false});
}

// class Category {
//   final String name;
//   final String imageUrl;
//
//
//   // Constructor to initialize the recipe
//   Category({required this.name, required this.imageUrl});
// }