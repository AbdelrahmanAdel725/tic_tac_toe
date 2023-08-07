import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String player1 = 'X';
  String player2 = 'O';

  String? currentPlayer;
  bool? gameEnd;
  List? selected;

  @override
  void initState() {
    initializeGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tic Tac Toe',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '$currentPlayer turn',
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          if (gameEnd! || selected![index].isNotEmpty) {
                            return;
                          }
                          setState(() {
                            selected![index] = currentPlayer;
                            changeTurn();
                            checkForWinner();
                            checkForDraw();
                          });
                        },
                        child: Container(
                            margin: const EdgeInsets.all(8),
                            color: selected![index].isEmpty
                                ? Colors.black26
                                : selected![index] == player1
                                    ? Colors.blue
                                    : Colors.orange,
                            child: Center(
                                child: Text(
                              selected![index],
                              style: const TextStyle(fontSize: 50),
                            ))),
                      )),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.15,
              child: ElevatedButton(onPressed: () {
                setState(() {
                  initializeGame();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                )
              ), child: const Text('Restart Game',style: TextStyle(fontSize: 25),),),
            )
          ],
        ),
      ),
    );
  }

  void initializeGame() {
    currentPlayer = player1;
    gameEnd = false;
    selected = ['', '', '', '', '', '', '', '', ''];
  }

  void changeTurn() {
    if (currentPlayer == player1) {
      currentPlayer = player2;
    } else {
      currentPlayer = player1;
    }
  }

  void checkForWinner() {
    List<List> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 4, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [2, 4, 6],
    ];

    for (var pos in winningList) {
      String playerPosition0 = selected![pos[0]];
      String playerPosition1 = selected![pos[1]];
      String playerPosition2 = selected![pos[2]];

      if (playerPosition0.isNotEmpty) {
        if (playerPosition0 == playerPosition1 &&
            playerPosition0 == playerPosition2) {
          showMessage('Player $playerPosition0 Won',Colors.green);
          gameEnd = true;
          return;
        }
      }
    }
  }

  void showMessage(String message,Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: color,
          content: Text(
            'Game Over\n $message',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25),
          )),
    );
  }

  void checkForDraw()
  {
    if(gameEnd!)
    {
      return;
    }
    bool draw = true;
    for(var player in selected!)
    {
      if(player.isEmpty)
      {
        draw = false;
      }
    }
    if(draw)
    {
      showMessage('Draw',Colors.grey);
      gameEnd = true;
    }
  }
}
