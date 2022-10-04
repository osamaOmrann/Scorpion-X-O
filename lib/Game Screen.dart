import 'package:flutter/material.dart';

import 'Color.dart';
import 'Game Logic.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = 'X';
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
  bool gameOver = false;
  int turn = 0;
  String result = "";

  Game game = Game();

  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's ${lastValue} Turn".toUpperCase(),
            style: TextStyle(fontSize: 58, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardLength ~/ 3,
              padding: EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardLength, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          if (game.board![index] == "") {
                            setState(() {});
                            game.board![index] = lastValue;
                            turn++;
                            gameOver = game.winnerCheck(
                                lastValue, index, scoreboard, 3);
                            if (gameOver) {
                              result = "$lastValue Wins";
                            } else if (!gameOver && turn == 9) {
                              result = "Draw";
                              gameOver = true;
                            }
                            if (lastValue == "X")
                              lastValue = "O";
                            else
                              lastValue = "X";
                          }
                        },
                  child: Container(
                    width: Game.blocSize,
                    height: Game.blocSize,
                    decoration: BoxDecoration(
                        color: MainColor.secondaryColor,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                            color: game.board![index] == "X"
                                ? MainColor.accentColor
                                : Colors.white54,
                            fontSize: 64.0),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Text(
            result,
            style: TextStyle(color: Colors.white, fontSize: 54.0),
          ),
          ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  game.board = Game.initGameBoard();
                  lastValue = 'X';
                  gameOver = false;
                  turn = 0;
                  result = "";
                  scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              icon: Icon(Icons.replay),
              label: Text("Repeat The Game"))
        ],
      ),
    );
  }
}
