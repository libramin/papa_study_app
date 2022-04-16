class FoodData {
  String foodName;
  String imageUrl;
  int servings;
  List<Ingredients> ingredients;

  FoodData(this.foodName,this.imageUrl,this.servings,this.ingredients);

}

class Ingredients {
  String name;
  String measure;
  double quantity;

  Ingredients(this.quantity,this.measure,this.name);
}

List<FoodData> foodList = [
  FoodData('pasta', 'assets/pasta.jpeg',1,[
    Ingredients(1, 'can', 'tomato Source'),
    Ingredients(60, 'g', 'pasta noodle'),
    Ingredients(30, 'g', 'mushroom'),
  ]),
  FoodData('pizza', 'assets/pizza.jpeg',1,[
    Ingredients(1, 'can', 'tomato Source'),
    Ingredients(30, 'g', 'mushroom'),
    Ingredients(30, 'g', 'cheese'),
  ]),
  FoodData('salad', 'assets/salad.jpeg',1,[
    Ingredients(15, 'g', 'yogart Source'),
    Ingredients(80, 'g', 'vegetable'),
    Ingredients(10, 'g', 'olive'),
  ]),
  FoodData('steak', 'assets/steak.jpeg',1,[
    Ingredients(600, 'g', 'beef'),
    Ingredients(10, 'g', 'salt'),
  ]),
];