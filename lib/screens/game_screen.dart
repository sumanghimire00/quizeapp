import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizeapp/provider/game_provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.difficultyLevel});
  final String difficultyLevel;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double? _deviceWidth, _deviceHeight;
  @override
  void initState() {
    final provider = Provider.of<GameProvider>(context, listen: false);

    provider.startGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<GameProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quize App",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth! * 0.05,
        ),
        child: Consumer<GameProvider>(
          builder: (context, value, child) {
            if (provider.questions == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _textWidget(provider.currentQuestion()),
                  Column(
                    children: [
                      //  for true
                      _checkButtom(
                          buttomName: "True",
                          color: Colors.green,
                          onPressed: () {
                            provider.answeQuestions("True", context);
                          }),
                      SizedBox(
                        height: _deviceHeight! * 0.01,
                      ),
                      // for false
                      _checkButtom(
                        buttomName: "False",
                        color: Colors.red,
                        onPressed: () {
                          provider.answeQuestions("False", context);
                        },
                      )
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  //  Widgets for UI
  Widget _textWidget(String questionName) {
    return Text(
      questionName,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
      ),
    );
  }

  Widget _checkButtom({
    required String buttomName,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return MaterialButton(
      minWidth: _deviceHeight! * 0.35,
      height: _deviceHeight! * 0.10,
      onPressed: onPressed,
      color: color,
      child: Text(
        buttomName,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
