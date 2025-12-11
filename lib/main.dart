import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'screens/home_screen.dart';
import 'screens/game_list_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/game_form_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GameProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Catalog',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        GameListScreen.routeName: (_) => const GameListScreen(),
        DetailScreen.routeName: (_) => const DetailScreen(),
        GameFormScreen.routeName: (_) => const GameFormScreen(),
      },
    );
  }
}
