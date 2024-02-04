class RecipesModel{
  String? RecipeName;
  String? Area;
  String? Category;
  String? Procedure;
  String? RecipeImage;
  String? RecipeVideo;
  String? Tags;
  bool? Fav;
  bool? InShoppingList;
  DateTime? RecipeDate;
  String? Recipeid;


  RecipesModel({this.Recipeid,this.RecipeName,this.Area,this.Category,this.Procedure,this.RecipeImage,this.RecipeVideo,this.Tags,this.Fav,this.InShoppingList,this.RecipeDate,});

}