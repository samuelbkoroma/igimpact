import 'package:flutter/material.dart';
import 'package:igniteimpact/components/BottomAppBar.dart';
import 'package:igniteimpact/screens/ApplyPage.dart' show ApplyPage;
import 'package:igniteimpact/screens/Authentication/ForgotPassword.dart';
import 'package:igniteimpact/screens/HomePage.dart';
import 'package:igniteimpact/screens/Notification.dart';
import 'package:igniteimpact/screens/SearchPage.dart';
import 'package:igniteimpact/screens/WelcomeScreen.dart';
import 'package:igniteimpact/screens/Authentication/login_screen.dart';
import 'package:igniteimpact/screens/Authentication/signup_screen.dart';
import 'package:igniteimpact/screens/settings.dart';

final Map<String, WidgetBuilder> routes = {
  '/welcome': (context) => const WelcomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => const SignUpScreen(),
  '/forgotpassword': (context) => const ForgotPasswordScreen(),
  '/homepage': (context) => const Homepage(),
  '/settings': (context) => const Settings(),
  '/bottomappbar': (context) => BottomAppbar(),
  '/notificationpage': (context) => const NotificationPage(),
  '/applypage': (context) => const ApplyPage(),
  '/searchpage': (context) => SearchPage(),
};
