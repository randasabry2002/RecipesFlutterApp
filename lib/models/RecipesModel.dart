class RecipesModel{
  String RecipeName;
  String Area;
  String Category;
  String Procedure;
  String RecipeImage;
  String RecipeVideo;
  String Tags;
  bool Fav;
  bool InShoppingList;
  DateTime RecipeDate;

  RecipesModel({required this.RecipeName,required this.Area,required this.Category,required this.Procedure,required this.RecipeImage,required this.RecipeVideo,required this.Tags,required this.Fav,required this.InShoppingList,required this.RecipeDate,});

}