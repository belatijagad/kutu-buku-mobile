import 'package:flutter/material.dart';
import 'package:kutubuku/screens/login.dart';
// import 'package:kutubuku/screens/register.dart';

// void main() => runApp(
//       MaterialApp(
//         initialRoute: '/home',
//         routes: {
//           // '': (context) => Loading(),
//           // '/landing': (context) => Landing(),
//           // '/add_food': (context) => AddFood(),
//           // '/food_list': (context) => FoodList(),
//           // '/individual_food': (context) => IndividualFood(),
//           // '/login': (context) => Login(),
//           // '/register': (context) => Register(),
//         },
//       ),
//     );

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.teal.shade50,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
