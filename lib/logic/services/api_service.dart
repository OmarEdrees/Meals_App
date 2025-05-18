import 'package:dio/dio.dart';
import 'package:meals_final_project/logic/services/object_for_get_api.dart';

List<ObjectForGetApi> recipes = [];

class ApiService {
  Dio dio = Dio();
  String baseUrl = 'https://dummyjson.com/recipes';
  Future<List<ObjectForGetApi>?> getRecipes() async {
    try {
      Response response = await dio.get(baseUrl);
      Map mapData = response.data;
      List recipesList = mapData['recipes'];

      for (var recipe in recipesList) {
        recipes.add(ObjectForGetApi.fromJson(recipe));
      }
      return recipes;
    } catch (e) {
      print('There is an error $e');
    }
    return null;
  }
}
