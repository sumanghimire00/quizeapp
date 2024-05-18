import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizeapp/provider/game_provider.dart';
import 'package:quizeapp/screens/home_page.dart';

void main() {
  runApp(const QuizeApp());
}

class QuizeApp extends StatelessWidget {
  const QuizeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameProvider>(
            create: (_) => GameProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "NotoSans-VariableFont_wdth",
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(38, 38, 38, 1.5),
        ),
        home: const HomePageScreen(),
      ),
    );
  }
}
