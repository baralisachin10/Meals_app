import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal;

  String get complexityText {
    final filterComplexityText = meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
    return filterComplexityText;
  }

  String get affordabilityText {
    final filterAffordabilityText = meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
    return filterAffordabilityText;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(context,meal);
        },
        child: Stack(children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(meal.imageUrl),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 6),
              child: Column(
                children: [
                  Text(
                    meal.title,
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MealItemTrait(
                          icon: Icons.schedule, label: '${meal.duration} min'),
                      MealItemTrait(icon: Icons.work, label: complexityText),
                      MealItemTrait(
                          icon: Icons.attach_money, label: affordabilityText),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
