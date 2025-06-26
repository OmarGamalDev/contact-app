import 'package:flutter/material.dart';

import '../../features/home/view/home_screen.dart';

Route<dynamic>onGenerateRoute(RouteSettings settings)
{
  switch (settings.name){
    case HomeScreen.routename:
      return MaterialPageRoute(builder: (_)=> HomeScreen());
    default:
      return MaterialPageRoute(builder: (_)=> Scaffold());
  }
}