import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/data/SQLiteConfig.dart';
import 'package:untitled/telas/config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

double MediaRspl = 0;

class _HomeState extends State<Home> {
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(milliseconds: 2500),
    () => 'a',
  );

  @override
  void initState() {
    findAll();
    findSwitch();
    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _calculation,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Center(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(9.5),
                              child: ListTile(
                                title: Text(
                                  "Gasolina Geral",
                                  textScaleFactor: 1.20,
                                ),
                                subtitle: Text(
                                    LastListrosGeral.toStringAsFixed(2) + " L",
                                    textScaleFactor: 2.25),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(9.5),
                              child: ListTile(
                                title: Text(
                                  "Quilometros Rodados",
                                  textScaleFactor: 1.20,
                                ),
                                subtitle: Text(
                                    KmViajadosGeral.toStringAsFixed(2) + " Km",
                                    textScaleFactor: 2.25),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(9.5),
                              child: ListTile(
                                title: Text(
                                  "Media Geral Km/L",
                                  textScaleFactor: 1.20,
                                ),
                                subtitle: Text(
                                    MediaGeral.toStringAsFixed(2) + " Km/L",
                                    textScaleFactor: 2.25),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                switchValue == true
                    ? Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(9.5),
                                    child: ListTile(
                                      title: Text(
                                        "Custo/L geral",
                                        textScaleFactor: 1.20,
                                      ),
                                      subtitle: Text(
                                          CustoLitroGeral.toStringAsFixed(2) +
                                              " R\$/L",
                                          textScaleFactor: 2.25),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 0,
                      ),
                switchValue == true
                    ? Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(9.5),
                                    child: ListTile(
                                      title: Text(
                                        "Custo Geral",
                                        textScaleFactor: 1.20,
                                      ),
                                      subtitle: Text(
                                          LastCustoGeral.toStringAsFixed(2) +
                                              " R\$",
                                          textScaleFactor: 2.25),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 0,
                      ),
              ],
            ),
          );
        });
  }
}

//     : Center(
// child: SpinKitRing(
// color: Colors.white,
// size: 50.0,
// ));
