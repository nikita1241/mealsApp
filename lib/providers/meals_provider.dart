import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/data/dummy_data.dart';

//create and save in var-provider object which we can listen to inside widgets
final mealsProvider = Provider((ref) {
  return dummyMeals; //list of meal objects //return value that u want to provide
});

//globally available providers useful when we hv dynamic data n cross widget state mngmnt

//import provider in file in which u want to use it