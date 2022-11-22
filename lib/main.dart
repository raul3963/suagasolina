import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/data/SQLiteConfig.dart';
import 'package:untitled/telas/Form.dart';
import 'package:untitled/telas/Home.dart';
import 'package:untitled/telas/Lista.dart';
import 'package:untitled/telas/SplashScreen.dart';
import 'package:untitled/telas/config.dart';

bool Abrindo = true;
int ValorBottomAppBar = 0;

void main() {
  runApp(MyApp());
}

String TituloAppBar = "Controle de Combustível";

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedTabIndex = 0;

  _changeIndex(int index) {
    setState(() {
      ValorBottomAppBar = index;
      index = ValorBottomAppBar;
      _selectedTabIndex = index;
    });
    if (ValorBottomAppBar == 0) {
      if (KmViajadosGeral < 0) {
        MediaGeral = 0;
        KmViajadosGeral = 0;
      }
      findSwitch();
      findAll();
      setState(() {
        TituloAppBar = "Controle de Combustível";
      });
    }
    if (ValorBottomAppBar == 1) {
      setState(() {
        TituloAppBar = "Novo Item";
      });
    }
    if (ValorBottomAppBar == 2) {
      findAll();
      setState(() {
        TituloAppBar = "Lista de Itens";
      });
    }
    if (ValorBottomAppBar == 3) {
      setState(() {
        TituloAppBar = "Configurações";
      });
    }
    print(index);
  }

  @override
  void initState() {
    findAll();
    findSwitch();
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: switchValueDm == true ? ThemeData.dark() : ThemeData.light(),
      home: Abrindo == true
          ? SplashScreen()
          : Scaffold(
              appBar: AppBar(
                title: Text(TituloAppBar),
              ),
              body: ValorBottomAppBar == 0
                  ? Home()
                  : ValorBottomAppBar == 1
                      ? Formulario()
                      : ValorBottomAppBar == 2
                          ? Lista()
                          : ValorBottomAppBar == 3
                              ? Configuration()
                              : Home(),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor:
                    switchValueDm == true ? Colors.cyanAccent : Colors.black,
                unselectedItemColor: Colors.grey,
                currentIndex: _selectedTabIndex,
                onTap: _changeIndex,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Painel',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: 'Novo',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Lista',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.wysiwyg),
                    label: 'Configurações',
                  ),
                ],
              ),
            ),
    );
  }
}
