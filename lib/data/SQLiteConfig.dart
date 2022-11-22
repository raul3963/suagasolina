import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/telas/Form.dart';
import 'package:untitled/telas/Home.dart';
import 'package:untitled/telas/Lista.dart';
import 'package:untitled/telas/config.dart';

final database = null;

class TabGasolina {
  final int id;
  final String data;
  final String kmAtual;
  final String gasolina;
  final String precogas;
  final String media;
  final String kmGeral;
  final String gasolinaGeral;
  final String custoGeral;

  TabGasolina(this.id, this.data, this.kmAtual, this.gasolina, this.precogas,
      this.media, this.kmGeral, this.gasolinaGeral, this.custoGeral);

  String toString() {
    return "TabGasolina{id: $id, data: $data, kmAtual: $kmAtual, gasolina: $gasolina, precogas: $precogas, media: $media, kmGeral: $kmGeral, gasolinaGeral: $gasolinaGeral, custoGeral: $custoGeral}";
  }
}

Future<Database> CreateDB() {
  return getDatabasesPath().then(
        (dbPath) {
      final String path = join(dbPath, 'controlegasolina');
      return openDatabase(path, onCreate: (db, version) {
        db.execute(
            'CREATE TABLE controlegasolina(id INTEGER NOT NULL PRIMARY KEY,'
                'data TEXT NOT NULL,'
                'kmAtual REAL NOT NULL,'
                'gasolina REAL NOT NULL,'
                'precogas REAL,'
                'media REAL,'
                'kmGeral REAL,'
                'gasolinaGeral REAL,'
                'custoGeral REAL)');
      }, version: 1);
    },
  );
}


Future<Database> CreateDBSwitch() {
  return getDatabasesPath().then(
        (dbPath) {
      final String path = join(dbPath, 'SwitchControl');
      return openDatabase(path, onCreate: (db, version) {
        db.execute(
            'CREATE TABLE SwitchControl(id INTEGER NOT NULL PRIMARY KEY,'
                'darkMode INTEGER NOT NULL,'
                'precoSwitch INTEGER NOT NULL)');
      }, version: 1);
    },
  );
}

class SwitchControl {
  final int id;
  final int darkMode;
  final int precoSwitch;

  SwitchControl(this.id, this.darkMode, this.precoSwitch);

  String toString() {
    return "SwitchControl{id: $id, darkMode: $darkMode, ValueSwitch: $precoSwitch}";
  }
}

Future<int> saveSwitch(SwitchControl switchControl) {
  // ignore: missing_return
  return CreateDBSwitch().then((db) {
    final Map<String, dynamic> listMap = Map();
    listMap["id"] = switchControl.id;
    listMap["darkMode"] = switchControl.darkMode;
    listMap["precoSwitch"] = switchControl.precoSwitch;
    TemSwitchData==false?db.insert('SwitchControl', listMap):db.update("SwitchControl", listMap);
  });
}

bool switchDataRecived = false;

Future<List<SwitchControl>> findSwitch() {
  return CreateDBSwitch().then(
        (db) {
      return db.query('SwitchControl').then(
            // ignore: missing_return
            (maps) {
          final List<SwitchControl> SwitchControls = List();
          for (Map<String, dynamic> map in maps) {
            final SwitchControl switchControl = SwitchControl(
                map["id"],
                map["darkMode"],
                map["precoSwitch"]);
            SwitchControls.add(switchControl);
          }
          print(SwitchControls.toString());
          SwitchControls.length==1?TemSwitchData=true:TemSwitchData=false;
          if(SwitchControls.last.darkMode==1){
            switchValueDm = true;
          }else{
            switchValueDm = false;
          }
          if(SwitchControls.last.precoSwitch==1){
            switchValue = true;
          }else{
            switchValue = false;
          }
        },
      );
    },
  );
}

bool TemSwitchData = false;


Future<int> save(TabGasolina tabGasolina) {
  return CreateDB().then((db) {
    final Map<String, dynamic> listMap = Map();
    listMap["id"] = tabGasolina.id;
    listMap["data"] = tabGasolina.data;
    listMap["kmAtual"] = tabGasolina.kmAtual;
    listMap["gasolina"] = tabGasolina.gasolina;
    listMap["precogas"] = tabGasolina.precogas;
    listMap["media"] = tabGasolina.media;
    listMap["kmGeral"] = tabGasolina.kmGeral;
    listMap["gasolinaGeral"] = tabGasolina.gasolinaGeral;
    listMap["custoGeral"] = tabGasolina.custoGeral;
    return db.insert('controlegasolina', listMap);
  });
}

double KmAnterior = 0;
double KmRodados = 0;
int LastId = 0;
int NewId = 0;
bool listaPegou = false;

double litrosGeral = 0;
double CustoMes = 0;
double KmViajados = 0;
double MediaGeral = 0;
double UltMedia = 0;
double LastKmViajados = 0;
double LastListrosGeral = 0;
double LastKmGeral = 0;
double LastCustoGeral = 0;
double CustoLitroGeral = 0;

int IdAntigoDois = 0;
bool dadosRecebidos = false;

bool CanSave = false;

DeleteAll() async {
  return CreateDB().then(
        (db) {
      return db.query('controlegasolina').then((dbPath) {
        db.execute("DELETE FROM controlegasolina WHERE id>-1;");
      });
    },
  );
}

bool TemData = false;
double KmViajadosGeral = 0;
double KmInicial = 0;

Future<List<TabGasolina>> findAll() {
  return CreateDB().then(
        (db) {
      return db.query('controlegasolina').then(
            (maps) {
          final List<TabGasolina> TabGasolinas = List();
          for (Map<String, dynamic> map in maps) {
            final TabGasolina tabGasolina = TabGasolina(
                map["id"],
                map["data"].toString(),
                map["kmAtual"].toString(),
                map["gasolina"].toString(),
                map["precogas"].toString(),
                map["media"].toString(),
                map["kmGeral"].toString(),
                map["gasolinaGeral"].toString(),
                map["custoGeral"].toString());
            TabGasolinas.add(tabGasolina);
          }
          if(TabGasolinas.length != 0){
          TemData = true;
          }else{
          TemData = false;
          }
          print(TabGasolinas.last);
          LastId = TabGasolinas.last.id;
          NewId = LastId + 1;
          listaPegou = true;
          FindAllResult = TabGasolinas.last.toString();
          KmAnterior = double.parse(TabGasolinas.last.kmAtual);
          UltMedia = double.parse(TabGasolinas.last.media);
          //  IdAntigoDois = LastId - 1;
          LastListrosGeral = double.parse(TabGasolinas.last.gasolinaGeral);
          KmViajadosGeral = LastKmGeral - KmInicial;
          LastKmGeral = double.parse(TabGasolinas.last.kmGeral);
          KmInicial = double.parse(TabGasolinas.first.kmGeral);
          MediaRspl = double.parse(TabGasolinas.last.precogas) /
          double.parse(TabGasolinas.last.gasolina);
          MediaGeral = KmViajadosGeral / LastListrosGeral;
          firstDataCreated = TabGasolinas.first.data;
          LastCustoGeral = double.parse(TabGasolinas.last.custoGeral);
          CustoLitroGeral = LastCustoGeral / LastListrosGeral;
          if (CanGetForSave == true) {
          litrosGeral =
          double.parse(TabGasolinas.last.gasolinaGeral) + Litros;
          CanSave = true;
          } else {
          CanSave = false;
          }
          dadosRecebidos
          =
          true;
          return
          TabGasolinas;
        },
      );
    },
  );
}

DeletSelected(){
  return CreateDB().then(
        (db) {
          print(ItemTapId.toString());
          TemData=false;
      return db.query('controlegasolina').then((dbPath) {
        db.execute("DELETE FROM controlegasolina WHERE id="+ ItemTapId.toString());
      });
    },
  );
}