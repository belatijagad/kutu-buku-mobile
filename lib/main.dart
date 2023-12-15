// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:kutubuku/screens/landing.dart';
import 'package:kutubuku/screens/register.dart';
import 'package:kutubuku/screens/login.dart';
import 'package:kutubuku/screens/searchbook.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CookieRequest(),
      child: MaterialApp(
        initialRoute: '/landing',
        routes: {
          '/landing': (context) => const BaseScreen(screen: Landing()),
          '/register': (context) => const BaseScreen(screen: RegisterScreen()),
          '/login': (context) => const BaseScreen(screen: LoginScreen()),
          '/search': (context) => const BaseScreen(screen: SearchScreen()),
        },
      ),
    );
  }
}

class BaseScreen extends StatefulWidget {
  final Widget screen;

  const BaseScreen({super.key, required this.screen});

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Landing(),
    const SearchScreen(),
    const LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
