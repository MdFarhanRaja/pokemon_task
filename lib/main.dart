import 'package:flutter/material.dart';
import 'package:flutter_task/providers/pokemon_list_provider.dart';
import 'package:flutter_task/screens/splash_scree.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(runWithProvider(const MainApp()));
}

runWithProvider(Widget app) {
  return MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => PokemonListProvider())],
    child: app,
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
