import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/data/SQLiteConfig.dart';
import '../main.dart';
import 'config.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<TabGasolina>>(
        future: Future.delayed(Duration(seconds: 1)).then((value) => findAll()),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            final List<TabGasolina> tabGasolinas = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                final TabGasolina Item = tabGasolinas[index];
                return _GasItem(Item);
              },
              itemCount: tabGasolinas.length == null ? 0 : tabGasolinas.length,
            );
          }
          return TemData == true
              ? SpinKitThreeBounce(
                  color: switchValueDm == true ? Colors.white : Colors.black)
              : Center(child: Text("Nenhum dado encontrado"));
        },
      ),
    );
  }
}

List<double> MediaGraf;

class _GasItem extends StatefulWidget {
  final TabGasolina Item;

  _GasItem(this.Item);

  @override
  __GasItemState createState() => __GasItemState();
}

int ItemTapId = -1;

class __GasItemState extends State<_GasItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: InkWell(
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(9.5),
                        child: ListTile(
                          title: Text(
                            widget.Item.data,
                            textScaleFactor: 1.50,
                          ),
                          subtitle: Text(
                              ItemTapId == widget.Item.id
                                  ? switchValue == true
                                      ? "Km Viajados: " +
                                          LastKmViajados.toString() +
                                          "\n" "Litros Abastecidos: " +
                                          widget.Item.gasolina +
                                          "\n" "Preço Pago: " +
                                          widget.Item.precogas +
                                          "\n" "Media: " +
                                          widget.Item.media
                                      : "Km Viajados: " +
                                          LastKmViajados.toString() +
                                          "\n" "Litros Abastecidos: " +
                                          widget.Item.gasolina +
                                          "\n" "Media: " +
                                          double.parse(widget.Item.media)
                                              .toStringAsFixed(2) +
                                          "\n"
                                  : "Clique Para Informações",
                              textScaleFactor:
                                  ItemTapId == widget.Item.id ? 1.25 : 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              if (ItemTapId == widget.Item.id) {
                ItemTapId = -1;
              }
              Timer(Duration(milliseconds: 10), () {
                setState(() {
                  ItemTapId = widget.Item.id;
                });
              });
              print(widget.Item.id);
            },
            onLongPress: () {
              ItemTapId = widget.Item.id;
              print(ItemTapId.toString());
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Confirmação'),
                  content: const Text('Deletar item selecionado?'),
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
                        DeletSelected();
                        Timer(Duration(milliseconds: 500), () {
                          findAll();
                        });
                        ValorBottomAppBar = 2;
                        Navigator.pop(context, 'OK');
                        main();
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
    );
  }
}
