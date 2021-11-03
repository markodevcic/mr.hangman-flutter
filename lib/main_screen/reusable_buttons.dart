import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../game_logic.dart';

class StartGameButton extends StatelessWidget {
  final String buttonLabel;
  final Function() onTapped;

  StartGameButton({Key? key, required this.buttonLabel, required this.onTapped})
      : super(key: key);

  final GameLogic gameLogic = GameLogic();

  @override
  Widget build(context) {
    return Card(
      elevation: 8,
      color: Colors.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTapped,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width,
          child: Text(
            '$buttonLabel\nGAME',
            textAlign: TextAlign.center,
            style: GoogleFonts.pressStart2p(fontSize: 18, height: 1.4),
          ),
        ),
      ),
    );
  }
}