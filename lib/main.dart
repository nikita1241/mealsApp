//Older versions of this course used the "provider" package instead of "riverpod" for app-wide state management.

// riverpod is a library created by the same developer as the provider library - it's essentially a re-write of the provider package, fixing many of the flaws of that library (also see: https://github.com/rrousselGit/riverpod).

//cross-widget state mngmt-Riverpod- use provider and consumer

//animations- 2 types
//explicit- you build and control entire animation, more control and more complexity
//implicit- you just tell the framework what you want to happen and it does the rest, flutter controls the animation, less control n less complexity, use pre-build animation widgets
//animation in categories scene

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    const ProviderScope( //to use riverpod fn , can use not only on whole app but also few parts
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}

