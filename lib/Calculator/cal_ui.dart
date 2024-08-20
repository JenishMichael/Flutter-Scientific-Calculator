import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class CalUI extends StatefulWidget {
  const CalUI({super.key});

  @override
  State<CalUI> createState() => _CalUIState();
}

class _CalUIState extends State<CalUI> {
  //Creating the properties
  String display = "";
  bool isScientific = false;
  //
  double heightValue = 70;
  double fontSizeValue = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 20, 25),
            height: 85,
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                display, //Y Error
                style: const TextStyle(fontSize: 50, color: Colors.white),
              ),
            ),
          ),
          if (isScientific)
            Row(
              children: [
                addBtn("2nd"),
                addBtn("rad"),
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
                addBtn("In"),
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
            children: [
              if (isScientific) addBtn("Sci"),
              if (isScientific) addBtn("e") else addBtn("Sci"),
              addBtn("0"),
              addBtn("."),
              addBtn("=")
            ],
          ),
        ],
      ),
    );
  }

  Expanded addBtn(btnText) {
    return Expanded(
      flex: 1,
      child: Container(
        //Height of Row
        height: heightValue,
        color: Colors.black,
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: ElevatedButton(
            child: Text(
              btnText,
              style: TextStyle(
                  fontSize: fontSizeValue, color: getColortxt(btnText)),
            ),
            onPressed: () {
              btnOnPressed(btnText);
            },
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                backgroundColor: WidgetStatePropertyAll(getBtnBg(btnText)))),
      ),
    );
  }

  Color getBtnBg(String txt) {
    if (txt == "=") {
      return Color.fromARGB(255, 255, 128, 0);
    } else {
      return Color.fromARGB(255, 51, 50, 50);
    }
  }

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

  void btnOnPressed(String btnText) {
    if (btnText == "Sci") {
      setState(() {
        isScientific = !isScientific;
        heightValue = isScientific ? 60 : 70;
        fontSizeValue = isScientific ? 15 : 25;
      });
    } else if (btnText == "AC") {
      setState(() {
        display = "";
      });
    } else if (btnText == "C") {
      setState(() {
        display = display.substring(0, display.length - 1);
      });
    } else if (btnText == "=") {
      print("Inside =");
      if (display.contains("%") && display.contains("x")) {
        print("Inside %,*");
        String displayReaplacedBoth =
            display.replaceAll("x", "*").replaceAll("%", "/100");
        print(displayReaplacedBoth);
        evalResult(displayReaplacedBoth);
      } else if (display.contains("x")) {
        print("Inside X");
        String displayReaplaced = display.replaceAll("x", "*");
        print("replace *");
        print(displayReaplaced);
        evalResult(displayReaplaced);
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
    Expression expression = Expression.parse(passedStr);
    ExpressionEvaluator evaluator = const ExpressionEvaluator();
    var result = evaluator.eval(expression, {});
    print(result);
    print(result.runtimeType);
    setState(() {
      display = result.toString();
    });
  }
}
