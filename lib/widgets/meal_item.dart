//meal image- implicit animation
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:meals/widgets/meal_item_trait.dart';
import 'package:meals/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder( //category meal card
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge, //to enforce shape given above as stack prohibitd that
      elevation: 2, //3d/shadow effect
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },

        child: Stack( //to posn multiple widgets above each other along z-axis - not like column
          children: [ 
            // start with bottom widget in stack,ie, in bg
            
            //to animate widget across diff screens
            //wrap widget u want to animate in Hero
            //then go to the place that u want to animate it to
            //from-meal_item to meal_detail screen
            Hero( 
              tag: meal.id, //to identify widget on this screen and target screen
              child: FadeInImage(//faded in image
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl), //so we get img from internet
                //for image ui
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            //to posn this widget on top of bottom/prev widget
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true, //text wrapped in good lookin way
                      overflow: TextOverflow.ellipsis, // Very long text ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    //meta data of meal
                    Row( //didnt use expanded as positioned already imposes constraints on it
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}