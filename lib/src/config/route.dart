import 'package:flutter/material.dart';
import 'package:marker/src/pages/home/home_page.dart';
import 'package:marker/src/pages/login/login_page.dart';
import 'package:marker/src/pages/signup/signup_page.dart';

class Route {
  static const home = '/home';
  static const login = '/login';
  static const signup = '/signup';

  static Map<String, WidgetBuilder> getRoute() => _route;

  static final Map<String, WidgetBuilder> _route = {
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    signup: (context) => const SignupPage(),
  };
}