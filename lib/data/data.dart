import 'dart:core';
import '../model/categories_model.dart';

const String apiKey = "FIpJzADaVlSuQFtVPEHTbSuTzP6yZ3ttc1uzzNrwsQTmKsU2MxhpzLXr";

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categoriesList = [];
  CategoriesModel categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500';
  categoriesModel.categoriesName = 'Street Art';
  categoriesList.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.categoriesName = "Wild Life";
  categoriesList.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.categoriesName = "Nature";
  categoriesList.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.categoriesName = "City";
  categoriesList.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categoriesModel.categoriesName = "Motivation";

  categoriesList.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.categoriesName = "Bikes";
  categoriesList.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.categoriesName = "Cars";
  categoriesList.add(categoriesModel);
  categoriesModel = CategoriesModel();


  return categoriesList;
}
