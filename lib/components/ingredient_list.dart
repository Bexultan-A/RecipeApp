
import 'package:flutter/cupertino.dart';
import 'package:reciepe_app/components/ingredient_item.dart';

class IngredientList extends StatelessWidget {
  final List<dynamic> ingredients;
  const IngredientList({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(
        parent: NeverScrollableScrollPhysics(),
      ),
      itemCount: ingredients.length,
      itemBuilder: (context, index){
        String quantity = ingredients[index]['quantity'].toString().substring(0,3);
        return IngredientItem(
          quantity: quantity,
          imageUrl: ingredients[index]['image']?? '',
          measure: ingredients[index]['measure']?? '',
          food: ingredients[index]['food']?? '',
        );      
    },);
  }
}