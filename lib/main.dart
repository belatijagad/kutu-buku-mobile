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
          // '/profile'
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
  bool _isLoggedIn = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _checkLoginStatus();
  // }

  Future<void> _checkLoginStatus() async {
    final request = context.watch<CookieRequest>();
    final loggedIn = request.loggedIn;
    setState(() {
      _isLoggedIn = loggedIn;
    });
  }

  final List<Widget> _screens = [
    const Landing(),
    const SearchScreen(),
    const LoginScreen(),
    // const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: _isLoggedIn
                ? const Icon(Icons.person)
                : const Icon(Icons.login),
            label: _isLoggedIn ? 'Profile' : 'Login',
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
