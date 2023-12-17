import 'package:flutter/material.dart';
import 'package:kutubuku/screens/edit_profile.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:kutubuku/screens/landing.dart';
import 'package:kutubuku/screens/register.dart';
import 'package:kutubuku/screens/login.dart';
import 'package:kutubuku/screens/searchbook.dart';
import 'package:kutubuku/screens/profile.dart';

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
          '/edit_profile': (context) => const BaseScreen(screen: EditProfile()),
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

  void _handleLogin() {
    setState(() {
      _isLoggedIn = true;
      _selectedIndex = 0;
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const Landing(),
      const SearchScreen(),
      _isLoggedIn
          ? ProfileScreen(onLogout: _handleLogout)
          : LoginScreen(onLogin: _handleLogin),
      // const ProfileScreen(),
    ];
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
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
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }
}
