import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //controller dos TextFields - peso e altura
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  //key do formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //texto abaixo do botão de calcular
  String _infoText = 'Informe seu dados!';

  //limpa os TextFields, reseta a mensagem de info e a chave do form
  void _resetFields() {
    weightController.text = '';
    heightController.text = '';

    setState(() {
      _infoText = 'Informe seu dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  //calcula o imc
  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      //atualiza a mensagem do resultado
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Header
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          //botão de reset
          actions: <Widget>[
            IconButton(
              onPressed: _resetFields,
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        //Corpo da tela
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //icone principal
                Icon(
                  Icons.person,
                  size: 120.0,
                  color: Colors.teal,
                ),
                //TextFormField de peso
                TextFormField(
                  //permite apenas números
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 25.0,
                  ),
                  controller: weightController,
                  //valida se o campo foi preenchido
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Insira seu peso!';
                    }
                  },
                ),
                //TextFormField de altura
                TextFormField(
                  //permite apenas números
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 25.0,
                  ),
                  controller: heightController,
                  //valida se o campo foi preenchido
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Insira sua altura!';
                    }
                  },
                ),
                //botão de calcular com padding
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      //verifica se o form foi valido e calcula o imc
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      color: Colors.teal,
                    ),
                  ),
                ),
                //texto de info
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 25.0,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
