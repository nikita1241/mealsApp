import 'package:flutter/material.dart';

import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/category.dart';

//for explicit animation, we hv to provide it in state so use stateful widget, as uistate has to be updated
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController; //late-doesnt have value when class is created but will hv a value as soon as it is used at first time

  @override
  //before build method executes
  void initState() {
    super.initState();

//has to be created in init state
    _animationController = AnimationController(
      vsync: this, //tickerprovider -ensures this animation runs for every frame, use with SingleTickerProviderStateMixin //60 fps, for eg
      duration: const Duration(milliseconds: 300),
      //between which value flutter animates
      //def settings
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward(); //u hv to explicitly start animation here-no repeat
    // .repeat-if we want to repeat it after it ends
  }

  @override
  void dispose() {
    //remove it when no need
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    //filter meal accd to category-list of specific category meals
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

//navigate to sel cattegory screen
//push meals screen on top of stack of screens
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    ); // Navigator.push(context, route)
  }


  @override
  Widget build(BuildContext context) {

    //doesnt build everything evrytime for 60 fps
    return AnimatedBuilder(
      animation: _animationController, //listenable object //tells when builder should be called eg 60 times per sec

      //grid
      //child here is-part which is part of animation but should not be animated themselves
      child: GridView(
        padding: const EdgeInsets.all(24),

        //layout of grid
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),

//explicit animation
//actual widget that would be animated and build again eg 60 times per sec
//animation would be played if app started not from when side drawer accd to logic imp now
      // builder: (context, child) => Padding( //animation logic-categoris come from mid bottom towards top
      //   padding: EdgeInsets.only(
      //     top: 100- _animationController.value * 100, //animationcontroller.value from lb:0 to up:1
      //   ),
      //   child: child,
      // ),

//better way of above animation
      builder: (context, child) => SlideTransition( //to animate movement of an elemnet from one posn to another
        position: Tween( //makes animatable object-this class is abt describing and animating the transition between 2 values
          begin: const Offset(0, 0.3),//(x,y) //0-no offset, 1-100% offset //describes offset from normal posn an element would take
          end: const Offset(0, 0), //end at actual posn
        ).animate( //returns animation over offset //control on how animation plays
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut, //start slow n end slow //transition way
          ),
        ),
        child: child,
      ),
    );
  }
}