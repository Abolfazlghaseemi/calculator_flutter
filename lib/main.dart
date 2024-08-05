import 'package:flutter/material.dart';
import 'package:ios_calculator/constants.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  var calculator = Calculator();
  runApp(calculator);
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _calculatorState();
}

class _calculatorState extends State<Calculator> {
  var inputUser = '';
  var result = '';

  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backGroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20, right: 15),
                            child: Text(
                              inputUser,
                              textAlign: TextAlign.end,
                              style: TextStyle(color: textColor, fontSize: 25),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              result,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 50,
                              ),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: backGroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow('CE', 'AC', '%', '/'),
                      getRow('7', '8', '9', '*'),
                      getRow('4', '6', '5', '-'),
                      getRow('1', '2', '3', '+'),
                      getRow('.', '0', '00', '='),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
              backgroundColor: getBackGroundColor(text1),
              minimumSize: Size(72, 72),
            ),
            onPressed: () {
              if (text1 == 'CE') {
                setState(() {
                  if (inputUser.length > 0) {
                    inputUser = inputUser.substring(0, inputUser.length - 1);
                  }
                });
              } else {
                buttonPressed(text1);
              }
            },
            child: Text(
              text1,
              style: TextStyle(fontSize: 30, color: textColor),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
              backgroundColor: getBackGroundColor(text2),
              minimumSize: Size(72, 72),
            ),
            onPressed: () {
              if (text2 == 'AC') {
                setState(() {
                  inputUser = '';
                  result = '';
                });
              } else {
                buttonPressed(text2);
              }
            },
            child: Text(
              text2,
              style: TextStyle(fontSize: 30, color: textColor),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
              backgroundColor: getBackGroundColor(text3),
              minimumSize: Size(72, 72),
            ),
            onPressed: () {
              buttonPressed(text3);
            },
            child: Text(
              text3,
              style: TextStyle(fontSize: 30, color: textColor),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
              backgroundColor: getBackGroundColor(text4),
              minimumSize: Size(72, 72),
            ),
            onPressed: () {
              if (text4 == '=') {
                Parser parser = Parser();
                Expression expression = parser.parse(inputUser);
                ContextModel contextModel = ContextModel();
                double eval =
                    expression.evaluate(EvaluationType.REAL, contextModel);
                setState(() {
                  result = eval.toString();
                });
              } else {
                buttonPressed(text4);
              }
            },
            child: Text(
              text4,
              style: TextStyle(fontSize: 30, color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator_CE(String text) {
    var list_CE = ['CE', 'AC', '%', '/'];
    return list_CE.contains(text);
  }

  bool isOperator(String text) {
    var list = ['÷', '*', '-', '+', '='];
    return list.contains(text);
  }

  Color getBackGroundColor(String text) {
    if (isOperator(text)) {
      return buttonGroundColor_blue;
    } else if (isOperator_CE(text)) {
      return buttonGroundColor_dark_light;
    } else {
      return buttonGroundColor;
    }
  }
}
