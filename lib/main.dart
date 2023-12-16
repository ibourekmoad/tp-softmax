import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  List<double> inputs = [0.0,0.0,0.0,0.0];
  List<double> outputs = [];

  void calculateSofmax(){
    List<double> val = inputs.map((e) => double.parse(e.toString())).toList();
    double sum = 0.0;
    List<double> scores = val.map((x) => exp(x)).toList();
    sum = scores.reduce((value, element) => value + element);
    setState(() {
      outputs = scores.map((score) => score / sum).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Softmax'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for(int i =0; i<inputs.length;i++)
                TextField(
                  controller: i ==0 ? _controller1: i==1? _controller2 : i == 2 ? _controller3 : _controller4,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Enter *${i + 1} value'),
                  onChanged: (value){
                    setState(() {
                      inputs[i] = double.tryParse(value) ?? 0.0 ;
                    });
                  },
                ),

              ElevatedButton(onPressed: calculateSofmax, child: Text('Calculate')),

              if (outputs.isNotEmpty)
                for (int i = 0; i < outputs.length; i++)
                  Text(
                    'p${i + 1}: ${outputs[i].toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20),
                  ),

            ],
          ),
          )

        ),
      ),
    );
  }

}
