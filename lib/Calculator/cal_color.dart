import 'package:flutter/material.dart';

class CalColor {
  //Method returns background color of Btn
  Color getBtnBg(String txt) {
    if (txt == "=") {
      return const Color.fromARGB(255, 255, 128, 0);
    } else {
      return const Color.fromARGB(255, 51, 50, 50);
    }
  }

  //Method returns TextColor of Btn
  Color getColortxt(String txt) {
    if (txt == "AC" ||
        txt == "C" ||
        txt == "%" ||
        txt == "/" ||
        txt == "+" ||
        txt == "-" ||
        txt == "x") {
      return const Color.fromARGB(255, 255, 128, 0);
    } else {
      return Colors.white;
    }
  }

  
}
