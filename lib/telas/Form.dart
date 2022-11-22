import 'dart:async';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/data/SQLiteConfig.dart';
import 'package:untitled/telas/config.dart';
import 'package:intl/intl.dart';

String FindAllResult = "";
bool CanGetForSave = false;
String Message = "";
String Data = '';
double Km = 0;
double Preco = 0;
double LitrosGeralAtual = 0;
double Litros = 0;
double Media = 0;
double MediaSimples = 0;
double kmGeral = 0;
double CustoGeralAt = 0;

String Datesave = "";

class Formulario extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

String dataPt = "";

class _FormState extends State<Formulario> {
  DateTime selectedData;
  final _km = TextEditingController();
  final _litros = TextEditingController();
  final _preco = TextEditingController();

  void clearText() {
    _km.clear();
    _litros.clear();
    _preco.clear();
    selectedData = DateTime.parse("");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          switchValueDm == false
              ? Padding(
                  padding: EdgeInsets.all(10),
                  child: DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle:
                          TextStyle(color: Colors.black54, fontSize: 20.0),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Data',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    dateFormat: DateFormat.d().add_M().add_y(),
                    onDateSelected: (DateTime value) {
                      print(value);
                      setState(() {
                        selectedData = value;
                      });
                      print("$selectedData");
                    },
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Data',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    dateFormat: DateFormat.d().add_M().add_y(),
                    onDateSelected: (DateTime value) {
                      print(value);
                      setState(() {
                        selectedData = value;
                      });
                      print("$selectedData");
                    },
                  ),
                ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _km,
              style: TextStyle(fontSize: 20.0, height: 1.0),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Km Atual',
                suffixIcon: Icon(Icons.directions_car),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _litros,
              style: TextStyle(fontSize: 20.0, height: 1.0),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Litros Abastecidos',
                suffixIcon: Icon(Icons.local_gas_station),
              ),
            ),
          ),
          switchValue == true
              ? Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _preco,
                    style: TextStyle(fontSize: 20.0, height: 1.0),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Preço Total Pago',
                        suffixIcon: Icon(Icons.attach_money)),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          Padding(
            padding: EdgeInsets.all(10),
            // ignore: deprecated_member_use
            child: RaisedButton(
              color: Colors.lightBlue,
              child: Text(
                "Salvar",
                style: TextStyle(fontSize: 15.0),
              ),
              onPressed: () {
                if (_km.text.contains(",") == false) {
                  if (_litros.text.contains(",") == false) {
                    if (_preco.text.contains(",") == false) {
                      setState(() {
                        Data = selectedData.toString();
                        _km.text == "" ? Km = 0 : Km = double.parse(_km.text);
                        _preco.text == ""
                            ? Preco = 0
                            : Preco = double.parse(_preco.text);
                        Litros = double.parse(_litros.text);
                        KmRodados = Km - KmAnterior;
                        Media = KmRodados / double.parse(_litros.text);
                        CanGetForSave = true;
                        DateTime DataParse = DateTime.parse(Data);
                        Datesave = DataParse.day.toString() +
                            "/" +
                            DataParse.month.toString() +
                            "/" +
                            DataParse.year.toString();
                        LitrosGeralAtual = LastListrosGeral + Litros;
                        kmGeral = KmAnterior + KmRodados;
                        switchValue == true
                            ? CustoGeralAt = LastCustoGeral + Preco
                            : null;
                      });

                      if (Km != 0) {
                        if (Litros != 0) {
                          if (Km > KmAnterior) {
                            CanGetForSave = false;
                            save(
                              TabGasolina(
                                NewId,
                                Datesave,
                                KmRodados.toString(),
                                Litros.toString(),
                                Preco.toString(),
                                Media.toString(),
                                kmGeral.toString(),
                                LitrosGeralAtual.toString(),
                                CustoGeralAt.toString(),
                              ),
                            );
                            findAll();
                            Timer(Duration(milliseconds: 750), () {
                              clearText();
                            });
                            setState(() {
                              Message = "";
                            });
                          } else {
                            setState(() {
                              Message =
                                  "Quilometragem menor que a anterior. Caso tenha trocado de veiculo por favor delete o dados na aba configuração";
                            });
                          }
                        } else {
                          setState(() {
                            Message = "Preencha o campo Litros";
                          });
                        }
                      } else {
                        setState(() {
                          Message = "Preencha o campo Km";
                        });
                      }
                    }else{
                      setState(() {
                        Message = 'Não utilize "," nos campos, use "." no lugar';
                      });
                    }
                  }else{
                    setState(() {
                      Message = 'Não utilize "," nos campos, use "." no lugar';
                    });
                  }
                }else{
                  setState(() {
                    Message = 'Não utilize "," nos campos, use "." no lugar';
                  });
                }
              },
            ),
          ),
          Text(
            Message,
            style: TextStyle(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
