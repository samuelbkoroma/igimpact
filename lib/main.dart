import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:igniteimpact/firebase_options.dart';
import 'package:igniteimpact/routes/routes.dart';
import 'package:igniteimpact/screens/WelcomeScreen.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'theme/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Ignite Impact',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme, // Add this line
      themeMode: themeProvider.themeMode,
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:igniteimpact/pages/Login.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Auth Screens',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }
