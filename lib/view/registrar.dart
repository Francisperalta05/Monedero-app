import 'package:flutter/material.dart';
import 'package:monedero/models/lista_model.dart';
import 'package:monedero/router/router.dart';
import 'package:monedero/servicio/servicios.dart';
import 'package:monedero/util/sizes.dart';

class Agregar extends StatefulWidget {
  @override
  _AgregarState createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  late TextEditingController _tituloController;
  late TextEditingController _precioController;

  late List<TxtContent> _textField;

  final _provider = Servicios();

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController();
    _precioController = TextEditingController();

    _textField = [
      TxtContent(
        id: 0,
        title: "Nombre",
        textEditingController: _tituloController,
        textInputType: TextInputType.text,
      ),
      TxtContent(
        id: 1,
        title: "Precio",
        textEditingController: _precioController,
        textInputType: TextInputType.phone,
      ),
    ];
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ..._textField.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TxtCodika(
                  txtController: e.textEditingController,
                  isBorder: true,
                  label: e.title,
                  inputType: e.textInputType,
                  txtRadiusBorder: 4,
                  containerPadding: EdgeInsets.all(10),
                  preffix: e.id == 1
                      ? Container(
                          padding: EdgeInsets.only(
                            top: 14,
                            left: 16,
                          ),
                          child: Text(
                            "RD\$ ",
                            style: textos(
                              ctn: context,
                              fSize: 18,
                            ),
                          ),
                        )
                      : null,
                ),
              );
            }).toList(),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: _provider.balance(),
              builder: (_, AsyncSnapshot<List<ListaModel>> snapshot) => InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text("Agregar"),
                  ),
                ),
                onTap: () {
                  _provider.agregar(
                    _tituloController.text,
                    int.parse(_precioController.text),
                  );
                  setState(() {
                    snapshot.data![0].precio -=
                        int.parse(_precioController.text);
                  });
                  _provider.modificarBalance(snapshot.data![0]);

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => Home(),
                      ),
                      (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
class TxtContent {
  int id;
  String title;
  TextEditingController textEditingController;
  TextInputType textInputType;

  TxtContent({
    required this.id,
    required this.title,
    required this.textEditingController,
    required this.textInputType,
  });
}
