import 'package:flutter/material.dart';

import '../constants.dart';
import 'board_item.dart';
import 'board_row.dart';

class BoardTile extends StatefulWidget {
  const BoardTile({
    super.key,
  });

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  List<BoardTypes> boardState = List.filled(9, BoardTypes.e);
  BoardTypes currentTurn = BoardTypes.x;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: screenWidth,
        height: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: chunk(boardState, 3).asMap().entries.map((listofTiles) {
            final index = listofTiles.key;
            final list = listofTiles.value;

            return BoardRow(
              items: list.asMap().entries.map(
                (tiles) {
                  final itemIndex = tiles.key;
                  final itemValue = tiles.value;

                  final tilePosition = index * 3 + itemIndex;

                  return BoardItem(
                    onPressed: () {
                      updateTiles(tilePosition);
                    },
                    type: itemValue,
                  );
                },
              ).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }

  void updateTiles(int selectedIndex) {
    if (boardState[selectedIndex] == BoardTypes.e) {
      setState(() {
        boardState[selectedIndex] = currentTurn;

        currentTurn = currentTurn == BoardTypes.x ? BoardTypes.o : BoardTypes.x;
      });

      final theWinner = findWinner();
      if (theWinner != null) {
        _showWinnerDialog(theWinner);
      }
    }
  }

  BoardTypes? findWinner() {
    BoardTypes? winnerForMatch(int a, int b, int c) {
      if (boardState[a] != BoardTypes.e) {
        if (boardState[a] == boardState[b] && boardState[b] == boardState[c]) {
          return boardState[a];
        }
      }

      return null;
    }

    final checks = [
      winnerForMatch(0, 1, 2),
      winnerForMatch(3, 4, 5),
      winnerForMatch(6, 7, 8),
      winnerForMatch(0, 3, 6),
      winnerForMatch(1, 4, 7),
      winnerForMatch(2, 5, 8),
      winnerForMatch(0, 4, 8),
      winnerForMatch(2, 4, 6),
    ];

    BoardTypes? winner;

    for (BoardTypes? check in checks) {
      if (check != null) {
        winner = check;
        break;
      }
    }
    return winner;
  }

  void _showWinnerDialog(BoardTypes winner) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          title: const Text(
            'Winner!',
            textAlign: TextAlign.center,
          ),
          content: Image.asset(
            winner == BoardTypes.o ? 'assets/o.png' : 'assets/x.png',
          ),
          actions: [
            SizedBox(
              child: TextButton(
                onPressed: _resetGame,
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).focusColor,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                ),
                child: const Text(
                  'New Game',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      boardState = List.filled(9, BoardTypes.e);
      currentTurn = BoardTypes.x;
    });

    Navigator.pop(context);
  }
}
