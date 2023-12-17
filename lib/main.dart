import 'package:flutter/material.dart';
import 'package:kutubuku/screens/edit_profile.dart';
import 'package:kutubuku/screens/landing.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/edit_profile',
        routes: {
          // '': (context) => Loading(),
          '/landing': (context) => Landing(),
          '/edit_profile':(context) => EditProfile()
          // '/add_food': (context) => AddFood(),
          // '/food_list': (context) => FoodList(),
          // '/individual_food': (context) => IndividualFood(),
          // '/login': (context) => Login(),
          // '/register': (context) => Register(),
        },
      ),
    );
