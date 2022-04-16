import 'package:flutter/material.dart';
import 'package:papa_study_app/datas/recipe_data.dart';

class RecipeDetailPage extends StatefulWidget {
   RecipeDetailPage({Key? key, required this.foodData}) : super(key: key);

  FoodData foodData;

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {

  int _sliderVal = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.foodData.foodName} Recipe'),
      ),
      body: Column(
        children: [
          Image.asset(widget.foodData.imageUrl),
          const SizedBox(height: 10.0,),
          Text('${widget.foodData.foodName} ingredients',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0
          ),),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: widget.foodData.ingredients.length,
                  itemBuilder: (context,index){
                  Ingredients ingredients = widget.foodData.ingredients[index];
                    return Text(
                        '${ingredients.quantity * _sliderVal} '
                        '${ingredients.measure} '
                        '${ingredients.name}');
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Slider(
              min: 1, max: 10, divisions: 10,
                value: _sliderVal.toDouble(),
                onChanged: (double newValue){
                setState(() {
                  _sliderVal = newValue.round();
                });
            },
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
              label: _sliderVal.toString(),
            ),
          )
        ],
      ),
    );
  }
}
