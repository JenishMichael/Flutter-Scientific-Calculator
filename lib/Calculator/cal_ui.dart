import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:sci_calculator/Calculator/cal_color.dart';

class CalUI extends StatefulWidget {
  const CalUI({super.key});

  @override
  State<CalUI> createState() => _CalUIState();
}

class _CalUIState extends State<CalUI> {
  //Creating the properties
  String display = "";
  bool isScientific = false;

  // For Calculation
  bool islg = false;
  bool isRadianBtn = true;
  bool checkIsDeg = true;

  // To set Value
  double heightValue = 70;
  double fontSizeValue = 25;

  //Creating obj of CalServices
  CalColor calColor = CalColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 20, 25),
            height: 95,
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerRight,
              child: AutoSizeText(
                display,
                style: const TextStyle(fontSize: 50, color: Colors.white),
                maxLines: 1,
              ),
            ),
          ),
          if (isScientific)
            Row(
              children: [
                addBtn("e"),
                if (isRadianBtn) addBtn("rad") else addBtn("deg"),
                addBtn("sin"),
                addBtn("cos"),
                addBtn("tan"),
              ],
            ),
          //If isScientific = true, then this row will execute
          if (isScientific)
            Row(
              children: [
                addBtn("xʸ"),
                addBtn("lg"),
                addBtn("ln"),
                addBtn("("),
                addBtn(")"),
              ],
            ),
          Row(
            children: [
              if (isScientific) addBtn("√x"),
              addBtn("AC"),
              addBtn("C"),
              addBtn("%"),
              addBtn("/")
            ],
          ),
          Row(
            children: [
              if (isScientific) addBtn("x!"),
              addBtn("7"),
              addBtn("8"),
              addBtn("9"),
              addBtn("x")
            ],
          ),
          Row(
            children: [
              if (isScientific) addBtn("1/x"),
              addBtn("4"),
              addBtn("5"),
              addBtn("6"),
              addBtn("-")
            ],
          ),
          Row(
            children: [
              if (isScientific) addBtn("π"),
              addBtn("1"),
              addBtn("2"),
              addBtn("3"),
              addBtn("+")
            ],
          ),
          Row(
            children: [addBtn("Sci"), addBtn("0"), addBtn("."), addBtn("=")],
          ),
        ],
      ),
    );
  }

  //Method take btn Name as Input and return as Button
  Expanded addBtn(btnText) {
    return Expanded(
      flex: btnText == "Sci" && isScientific ? 2 : 1,
      child: Container(
        //Height of Row
        height: heightValue,
        color: Colors.black,
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: ElevatedButton(
            child: Text(
              btnText,
              style: TextStyle(
                  fontSize: fontSizeValue,
                  color: calColor.getColortxt(btnText)),
            ),
            onPressed: () {
              btnOnPressed(btnText);
            },
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                backgroundColor:
                    WidgetStatePropertyAll(calColor.getBtnBg(btnText)))),
      ),
    );
  }

  //This Method is called when a btn is clicked
  void btnOnPressed(String btnText) {
    if (btnText == "Sci") {
      setState(() {
        isScientific = !isScientific;
        heightValue = isScientific ? 60 : 70;
        fontSizeValue = isScientific ? 13 : 25;
      });
    } else if (btnText == "ln") {
      islg = false;
      setState(() {
        display += "ln";
      });
    } else if (btnText == "lg") {
      islg = true;
      setState(() {
        display += "lg";
      });
    } else if (btnText == "rad") {
      isRadianBtn = false;
      checkIsDeg = false;
      setState(() {});
    } else if (btnText == "deg") {
      isRadianBtn = true;
      checkIsDeg = true;
      setState(() {});
    } else if (btnText == "xʸ") {
      setState(() {
        display += "^";
      });
    } else if (btnText == "AC") {
      setState(() {
        display = "";
      });
    } else if (btnText == "C") {
      setState(() {
        display = display.substring(0, display.length - 1);
      });
    } else if (btnText == "x!") {
      setState(() {
        display += "!";
      });
    } else if (btnText == "1/x") {
      setState(() {
        display += "^(-1)";
      });
    } else if (btnText == "√x") {
      setState(() {
        display += "√";
      });
    } else if (btnText == "=") {
      if (display.contains("π") ||
          display.contains("x") ||
          display.contains("%") ||
          display.contains("e") ||
          display.contains("x!") ||
          display.contains("√x") ||
          display.contains("ln(") ||
          display.contains("lg(")) {
        String displayReplaced = display
            .replaceAll("π", "3.14159265359")
            .replaceAll("%", "/100")
            .replaceAll("x", "*")
            .replaceAll("e", "2.71828182846")
            .replaceAll("x!", "!")
            .replaceAll("ln(", "log(")
            .replaceAll("lg(", "log(");

        evalResult(displayReplaced);
      } else {
        evalResult(display);
      }
    } else {
      setState(() {
        display += btnText;
      });
    }
  }

  void evalResult(String passedStr) {
    var result;
    if (display.contains("/0")) {
      result = "Can't divide by zero";
    } else if (passedStr.contains("log(") && islg) {
      var result1 = passedStr.interpret().toDouble();
      result = result1 / log(10);
    } else if ((passedStr.startsWith("sin(") ||
            passedStr.startsWith("cos(") ||
            passedStr.startsWith("tan(")) &&
        !checkIsDeg) {
      int length = passedStr.length;

      String angleStr = passedStr.substring(4, length - 1);

      double angleD = double.parse(angleStr);
      double radian = angleD * (3.14159265359 / 180);

      if (passedStr.contains("sin")) {
        double degree = sin(radian);
        result = degree.toStringAsPrecision(2);
      } else if (passedStr.contains("cos")) {
        double degree = cos(radian);
        result = degree.toStringAsPrecision(2);
      } else {
        double degree = tan(radian);
        result = degree.toStringAsPrecision(2);
      }
    } else {
      result = passedStr.interpret().toDouble();
    }
    print(result.runtimeType);
    print(result);

    setState(() {
      display = result.toString();
    });
  }
}
