import 'package:flutter/material.dart';
import 'package:untitled/data/SQLiteConfig.dart';
import 'dart:async';

class Configuration extends StatefulWidget {
  @override
  _ConfigurationState createState() => _ConfigurationState();
}


int dm = 1;
int precoswitch = 1;
String firstDataCreated = "";
bool Value = false;
bool ValueDm = false;
bool switchValue = true;
bool switchValueDm = true;

class _ConfigurationState extends State<Configuration> {
  bool status = false;

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(milliseconds: 2500),
        () => 'a',
  );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 1),
              child: Row(
                children: [
                  Switch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(
                        () {
                          switchValue = value;
                          Value = switchValue;
                          switchValue==true?precoswitch=1:precoswitch=0;
                          saveSwitch(SwitchControl(1, dm, precoswitch));
                        },
                      );
                    },
                  ),
                  Text("Usar dados de preço"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(vertical: 1),
              child: Row(
                children: [
                  Switch(
                    value: switchValueDm,
                    onChanged: (ValueDm) {
                      setState(
                        () {
                          switchValueDm = ValueDm;
                          ValueDm = switchValueDm;
                          switchValueDm==true?dm = 1:dm = 0;
                          saveSwitch(SwitchControl(1, dm, precoswitch));
                        },
                      );
                    },
                  ),
                  Text("dark mode"),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text(
                "Deletar Todos os Dados",
                style: TextStyle(fontSize: 15.0),
              ),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Confirmação'),
                    content: const Text(
                        'Você tem certeza que deseja deletar todos os dados?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          LastListrosGeral = 0;
                          LastKmGeral = 0;
                          MediaGeral = 0;
                          CustoLitroGeral = 0;
                          LastCustoGeral = 0;
                          KmAnterior = 0;
                          UltMedia = 0;
                          LastListrosGeral = 0;
                          LastKmGeral = 0;
                          MediaGeral = 0;
                          LastCustoGeral = 0;
                          CustoLitroGeral = 0;
                          KmViajadosGeral = 0;
                          KmRodados = 0;
                          DeleteAll();
                          Timer(Duration(seconds: 2),(){
                            findAll();
                          });
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('Deletar'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
