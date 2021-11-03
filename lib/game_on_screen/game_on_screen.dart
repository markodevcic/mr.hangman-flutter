import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hangman/game_logic.dart';
import 'package:hangman/main_screen/main_screen_components.dart';
import 'package:hangman/player_input_word_screen/player_input_word_screen.dart';

class GameOnScreen extends StatefulWidget {
  final String word;
  String hiddenWord;

  GameOnScreen({Key? key, required this.word, required this.hiddenWord})
      : super(key: key);

  final GameLogic gameLogic = GameLogic();
  List disabledLetters = [];
  int hangmanPic = 0;

  @override
  _GameOnScreenState createState() => _GameOnScreenState();
}

class _GameOnScreenState extends State<GameOnScreen> {
  List<String> alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    'Are you going to abandon Mr. Hangman?',
                    style: GoogleFonts.pressStart2p(),
                  ),
                  actions: [
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          willLeave = true;
                          Navigator.of(context).pop();
                        },
                        child:
                            Text('Sorry', style: GoogleFonts.pressStart2p())),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade600,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child:
                            Text('Never!', style: GoogleFonts.pressStart2p()))
                  ],
                ));
        return willLeave;
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 3 / 10,
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'images/hangman${widget.hangmanPic}.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    widget.hiddenWord,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pressStart2p(fontSize: 18, height: 1.5),
                  ),
                  if (widget.hangmanPic == 6)
                    Text(
                      'YOU FAILED TO SAVE MR. HANGMAN!',
                      style:
                          GoogleFonts.pressStart2p(fontSize: 20, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  if (widget.hangmanPic == 7)
                    Text(
                      'YOU FREED MR. HANGMAN!',
                      style:
                          GoogleFonts.pressStart2p(fontSize: 20, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  if (widget.hangmanPic < 6)
                    Wrap(
                      spacing: 1,
                      runSpacing: 1,
                      alignment: WrapAlignment.center,
                      children: alphabet
                          .map(
                            (char) => MaterialButton(
                              child: Text(
                                char,
                                style: GoogleFonts.pressStart2p(fontSize: 14),
                              ),
                              padding: const EdgeInsets.all(2),
                              minWidth: 60,
                              onPressed: (widget.disabledLetters.contains(char))
                                  ? null
                                  : () {
                                      (widget.word.contains(char))
                                          ? setState(() {
                                              widget.disabledLetters.add(char);
                                              widget.hiddenWord = widget
                                                  .gameLogic
                                                  .revealHiddenWord(
                                                      widget.hiddenWord,
                                                      widget.word,
                                                      char);
                                              if (widget.hiddenWord ==
                                                  widget.word) {
                                                widget.hangmanPic = 7;
                                              }
                                            })
                                          : setState(
                                              () {
                                                widget.disabledLetters
                                                    .add(char);
                                                widget.hangmanPic += 1;
                                              },
                                            );
                                    },
                            ),
                          )
                          .toList(),
                    ),
                  if (widget.hangmanPic == 6 || widget.hangmanPic == 7)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StartGameButton(
                          buttonLabel: 'NEW QUICK',
                          onTapped: () {
                            String word =
                                widget.gameLogic.quickGameWordGenerator();
                            String hiddenWord = widget.gameLogic.hideWord(word);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => GameOnScreen(
                                        word: word, hiddenWord: hiddenWord)));
                          },
                        ),
                        StartGameButton(
                          buttonLabel: '2 PLAYER',
                          onTapped: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlayerInputWordScreen()));
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
