// To parse this JSON data, do
//
//     final lista = listaFromJson(jsonString);

import 'dart:convert';

ListaModel listaFromJson(String str) => ListaModel.fromJson(json.decode(str));

String listaToJson(ListaModel data) => json.encode(data.toJson());

class ListaModel {
  ListaModel({
    this.id,
    this.nombre,
    this.precio,
    this.fecha,
  });

  String id;
  String nombre;
  int precio;
  DateTime fecha;

  factory ListaModel.fromJson(Map<String, dynamic> json) => ListaModel(
        id: json["id"],
        nombre: json["nombre"],
        precio: json["precio"],
        fecha: DateTime.parse(json["fecha"]),
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "precio": precio,
        "id": id,
        "fecha": fecha.toIso8601String(),
      };
}
