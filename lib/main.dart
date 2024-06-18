import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final wtController = TextEditingController();
  final ftController = TextEditingController();
  final inchController = TextEditingController();

  String result = "";
  var bgColor = Colors.indigo.shade200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
      body: Container(
        color: bgColor,
        child: Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BMI',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 21),
                TextField(
                  controller: wtController,
                  decoration: InputDecoration(
                    labelText: 'Enter your weight in kgs',
                    prefixIcon: Icon(Icons.line_weight),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15),
                TextField(
                  controller: ftController,
                  decoration: InputDecoration(
                    labelText: 'Enter your height in feet',
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15),
                TextField(
                  controller: inchController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your height in inches',
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    var wt = wtController.text;
                    var ft = ftController.text;
                    var inch = inchController.text;

                    if (wt.isNotEmpty && ft.isNotEmpty && inch.isNotEmpty) {
                      // BMI calculation
                      var iwt = int.parse(wt);
                      var ift = int.parse(ft);
                      var iInch = int.parse(inch);

                      var tInch = (ift * 12) + iInch;
                      var tCm = tInch * 2.54;
                      var tM = tCm / 100;

                      var bmi = iwt / (tM * tM);

                      var msg="";
                      if(bmi>25){
                        msg="You are OverWeight!!";
                        bgColor=Colors.orange.shade200;

                      }else if(bmi<18){
                        msg="You are underweight!!";
                        bgColor=Colors.red.shade200;

                      }else{
                        msg="You are healthy!!";
                        bgColor=Colors.green.shade200;

                      }

                      setState(() {
                        result = "$msg \n Your BMI is ${bmi.toStringAsFixed(2)}";
                      });
                    } else {
                      setState(() {
                        result = "Please fill all the required fields!";
                      });
                    }
                  },
                  child: const Text('Calculate'),
                ),
                const SizedBox(height: 16),
                Text(
                  result,
                  style: const TextStyle(fontSize: 19),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}