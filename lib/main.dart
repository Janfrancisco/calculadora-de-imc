import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Infome seus dados!";

  set infoText(String text) {
    _infoText = text;
  }

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsFixed(2)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsFixed(2)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsFixed(2)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau I (${imc.toStringAsFixed(2)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade grau II (${imc.toStringAsFixed(2)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade grau III (${imc.toStringAsFixed(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          backgroundColor: Colors.green,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.people, size: 120, color: Colors.green),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (Kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 50),
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 50),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira a sua altura";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    style: TextStyle(fontSize: 50, color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )));
  }
}
