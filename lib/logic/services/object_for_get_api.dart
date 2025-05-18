class ObjectForGetApi {
  String name;
  String prepTimeMinutes;
  String caloriesPerServing;
  String image;
  String rating;
  String reviewCount;
  //List<String> mealType;
  List<dynamic> ingredients;
  List<dynamic> instructions;

  ObjectForGetApi({
    required this.instructions,
    required this.name,
    required this.image,
    required this.caloriesPerServing,
    required this.ingredients,
    //required this.mealType,
    required this.prepTimeMinutes,
    required this.rating,
    required this.reviewCount,
  });

  factory ObjectForGetApi.fromJson(Map recipe) {
    return ObjectForGetApi(
      instructions: recipe['instructions'],
      ingredients: recipe['ingredients'],
      name: recipe['name'],
      image: recipe['image'],
      caloriesPerServing: recipe['caloriesPerServing'].toString(),
      //mealType: recipe['mealType'],
      prepTimeMinutes: recipe['prepTimeMinutes'].toString(),
      rating: recipe['rating'].toString(),
      reviewCount: recipe['reviewCount'].toString(),
    );
  }
}
