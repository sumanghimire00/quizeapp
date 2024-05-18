import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizeapp/provider/game_provider.dart';
import 'package:quizeapp/screens/game_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  double? deviceWidth, deviceHeight;
  double currentDifficultylevel = 0;
  List<String> difficultyText = ["easy", "medium", "hard"];
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth! * 0.10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  _appTitle(),
                  _difficultyTitle(),
                ],
              ),
              _difficultySlider(),
              _startGameButtom(),
            ],
          ),
        ),
      )),
    );
  }

  Widget _appTitle() {
    return const Text(
      "Quize App",
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w500,
        color: Colors.amber,
      ),
    );
  }

//  Difficult Title Text
  Widget _difficultyTitle() {
    return Text(
      difficultyText[currentDifficultylevel.toInt()],
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
  //  Difficulty Slider

  Widget _difficultySlider() {
    return Slider(
      max: 2,
      min: 0,
      divisions: 2,
      label: difficultyText[currentDifficultylevel.toInt()],
      value: currentDifficultylevel,
      onChanged: (value) {
        setState(
          () {
            currentDifficultylevel = value;
          },
        );
      },
    );
  }

  //  Start Game Button Widget

  Widget _startGameButtom() {
    return MaterialButton(
      height: deviceHeight! * 0.08,
      minWidth: deviceWidth! * 0.50,
      shape: const StadiumBorder(
        side: BorderSide(color: Colors.white),
      ),
      color: Colors.indigo,
      child: const Text(
        "Start Game",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GamePage(
              difficultyLevel:
                  Provider.of<GameProvider>(context).setDifficultyLevel(
                value: difficultyText[currentDifficultylevel.toInt()]
                    .toLowerCase(),
              ),
            ),
          ),
        );
      },
    );
  }
}
