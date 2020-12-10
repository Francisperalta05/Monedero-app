import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monedero/models/lista_model.dart';
import 'package:monedero/servicio/servicios.dart';
import 'package:monedero/util/sizes.dart';
import 'package:monedero/widgets/precio_total.dart';
import 'package:shimmer/shimmer.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  final _provider = Servicios();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _lista(context),
          ),
          PrecioTotal(),
        ],
      ),
    );
  }

  Widget _lista(BuildContext context) {
    return FutureBuilder(
        future: _provider.lista(),
        builder: (context, AsyncSnapshot<List<ListaModel>> snapshot) {
          if (!snapshot.hasData) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48.0,
                        height: 48.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: 10,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, i) {
                return InkWell(
                  onLongPress: () => _alertaEliminar(context, snapshot.data[i]),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                          Sizes(16).sizes(context),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text("${snapshot.data[i].nombre} "),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text("RD\$ ${snapshot.data[i].precio} "),
                            ),
                            Spacer(),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                "${DateFormat.yMMMEd().format(snapshot.data[i].fecha)} ${DateFormat('hh:mm a').format(snapshot.data[i].fecha)}",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                      ),
                    ],
                  ),
                );
              },
            );
          }
        });
  }

  void _alertaEliminar(BuildContext context, ListaModel listaModel) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Eliminar ${listaModel.nombre}"),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("No"),
          ),
          FlatButton(
            onPressed: () async {
              await _provider.borrar(listaModel.id);
              Navigator.of(context).pop();
              setState(() {});
            },
            child: Text("Si"),
          ),
        ],
      ),
    );
  }
}
