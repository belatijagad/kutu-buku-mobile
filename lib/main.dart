import 'package:flutter/material.dart';
import 'package:kutubuku/screens/landing.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/landing',
        routes: {
          // '': (context) => Loading(),
          '/landing': (context) => Landing(),
          // '/add_food': (context) => AddFood(),
          // '/food_list': (context) => FoodList(),
          // '/individual_food': (context) => IndividualFood(),
          // '/login': (context) => Login(),
          // '/register': (context) => Register(),
        },
      ),
      home: SearchBookScreen(),
    );
  }
}