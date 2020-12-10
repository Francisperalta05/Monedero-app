import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:monedero/models/lista_model.dart';

class Servicios {
  String _url = "https://monedero-b3669.firebaseio.com";

  Future<List<ListaModel>> lista() async {
    final resp = await http.get("$_url/lista.json");

    final Map<String, dynamic> decodedData = jsonDecode(resp.body);

    // final data = User.fromJson(decodedData);

    final List<ListaModel> listas = new List();

    decodedData.forEach((id, lista) {
      final listaTemp = ListaModel.fromJson(lista);
      listaTemp.id = id;

      listas.add(listaTemp);
    });

    return listas;
  }

  Future<List<ListaModel>> balance() async {
    final resp = await http.get("$_url/balance.json");

    final Map<String, dynamic> decodedData = jsonDecode(resp.body);

    // final data = User.fromJson(decodedData);

    final List<ListaModel> listas = new List();

    decodedData.forEach((id, lista) {
      final listaTemp = ListaModel.fromJson(lista);
      listaTemp.id = id;

      listas.add(listaTemp);
    });

    return listas;
  }

  Future<bool> agregar(String nombre, int precio) async {
    Map data = {
      'nombre': nombre,
      'precio': precio,
      'fecha': DateTime.now().toString(),
    };

    String body = json.encode(data);
    final resp = await http.post(
      "$_url/lista.json",
      body: body,
    );
    print(resp.body);
    return true;
  }

  Future<int> borrar(String id) async {
    final url = '$_url/lista/$id.json';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }

  Future<bool> modificarBalance(ListaModel lista) async {
    final url = '$_url/balance/${lista.id}.json';
    final resp = await http.put(url, body: listaToJson(lista));
    final decodedData = jsonDecode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> modificarTotal(ListaModel lista) async {
    final url = '$_url/balance/${lista.id}.json';
    final resp = await http.put(url, body: listaToJson(lista));
    final decodedData = jsonDecode(resp.body);

    print(decodedData);

    return true;
  }
}
