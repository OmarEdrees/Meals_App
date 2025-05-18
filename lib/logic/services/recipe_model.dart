class RecipeModel {
  String name;
  String image;
  String caloriesPerServing;
  String prepTimeMinutes;
  RecipeModel({
    required this.name,
    required this.image,
    required this.caloriesPerServing,
    required this.prepTimeMinutes,
  });

  factory RecipeModel.fromjson(Map json) {
    return RecipeModel(
      name: json['name'],
      image: json['image'],
      caloriesPerServing: json['caloriesPerServing'],
      prepTimeMinutes: json['prepTimeMinutes'],
    );
  }
}
