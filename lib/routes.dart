import 'package:flutter/material.dart';
import 'package:anzus/pages/HomeScreen.dart';

Map<String, WidgetBuilder> buildAppRoutes(){
  return {
    '/HomeScreen':(BuildContext context) => new HomeScreen(),
  };
}