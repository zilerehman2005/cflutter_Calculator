

 import 'package:flutter/material.dart';
import 'package:flutter_calculator/history.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}
  class CalculatorApp extends StatelessWidget {
    const CalculatorApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CalculatorAppHome(),
      );
    }
  }

class CalculatorAppHome extends StatefulWidget {
  const CalculatorAppHome({super.key});

  @override
  State<CalculatorAppHome> createState() => _CalculatorAppHomeState();
}

class _CalculatorAppHomeState extends State<CalculatorAppHome> {
  String equation='0';
  String result='0';
  String expression='';
  buttonPressed(btnText) {
    setState(() {
      if (btnText == 'AC') {
        equation = '0';
        result = '0';
      } else if (btnText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (btnText == '=') {
        try {
          expression = equation;
          expression = expression.replaceAll('X', '*');
          expression = expression.replaceAll('÷', '/');
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (equation == '0') {
          equation = btnText;
        } else {
          // Check if the last character in the equation is an operator
          String lastChar = equation.substring(equation.length - 1);
          if (_isOperator(lastChar) && _isOperator(btnText)) {
            result = 'Error';
            return; // Exit the method early if consecutive operators are detected
          }
          equation += btnText;
        }
      }
    });
  }

// Helper method to check if a character is an operator
  bool _isOperator(String character) {
    return character == '+' || character == '-' || character == 'X' || character == '÷';
  }



  Widget calButton(String btnTxt,Color txtColor,double btnWidth, Color btnColor){
    return  InkWell(
      onTap: (){
        buttonPressed(btnTxt);
      },
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width:btnWidth,
        decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.circular(50)
        ),
        child: Text(btnTxt,style: TextStyle(color: txtColor,fontSize: 30,fontWeight: FontWeight.w500),),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Calculator'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: Text('History'),
                onTap: () async {
                  Navigator.pop(context); // Close the drawer
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()), // Navigate to the HistoryScreen
                  );
                  // You can add logic here to handle any updates to the calculator screen after navigating back from the history screen
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        appBar: AppBar(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.elliptical(200, 100)
            )
          ),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          title: Text("Developed by ZILLE ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 30),),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              height: 90,
              width: double.infinity,
              color: Colors.black,
              child: SingleChildScrollView(child: Text(equation,style: TextStyle(color: Colors.deepOrangeAccent[100],fontSize: 30),)),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              height: 90,
              width: double.infinity,
              color: Colors.black,
              child: Text(result,style: TextStyle(color: Colors.deepOrangeAccent[100],fontSize: 60),),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       calButton('AC', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                       calButton('⌫', Colors.white, 80, Colors.white30),
                       calButton('%', Colors.white, 80, Colors.white30),
                       calButton('÷', Colors.white, 80, Colors.deepOrangeAccent[100]!),

                      ],
                    ),
                    SizedBox(height: 18,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButton('(', Colors.white, 80, Colors.white10),
                        calButton(')', Colors.white, 80, Colors.white10),
                        calButton('{', Colors.white, 80, Colors.deepOrangeAccent[100]!),
                        calButton('}', Colors.white, 80, Colors.deepOrangeAccent[100]!),


                      ],
                    ),
                    SizedBox(height: 25,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButton('7', Colors.white, 80, Colors.white10),
                        calButton('8', Colors.white, 80, Colors.white10),
                        calButton('9', Colors.white, 80, Colors.white10),
                        calButton('X', Colors.white, 80, Colors.deepOrangeAccent[100]!),

                      ],
                    ),
                    SizedBox(height: 18,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButton('4', Colors.white, 80, Colors.white10),
                        calButton('5', Colors.white, 80, Colors.white10),
                        calButton('6', Colors.white, 80, Colors.white10),
                        calButton('-', Colors.white, 80, Colors.deepOrangeAccent[100]!),

                      ],
                    ),
                    SizedBox(height: 18,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButton('1', Colors.white, 80, Colors.white10),
                        calButton('2', Colors.white, 80, Colors.white10),
                        calButton('3', Colors.white, 80, Colors.white10),
                        calButton('+', Colors.white, 80, Colors.deepOrangeAccent[100]!),

                      ],
                    ),
                    SizedBox(height: 18,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        calButton('0', Colors.white, 170, Colors.white10),
                        calButton('.', Colors.white, 80, Colors.white10),
                        calButton('=', Colors.white, 80, Colors.deepOrangeAccent[100]!),

                      ],
                    ),
                    SizedBox(height: 18,),


                  ],
                ),
              ),
            )
          ],
        ),
      ),

      ),
    );
  }
}
