import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monedero/models/lista_model.dart';
import 'package:monedero/router/router.dart';
import 'package:monedero/servicio/servicios.dart';
import 'package:monedero/util/sizes.dart';
import 'package:monedero/view/registrar.dart';
import 'package:monedero/widgets/my_textfield.dart';
import 'package:monedero/widgets/precio_total.dart';

class Balance extends StatefulWidget {
  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  TextEditingController _precioController;
  NumberFormat numberFormat = NumberFormat('#,##0.00');

  final _provider = Servicios();

  List<TxtContent> _textField;

  @override
  void initState() {
    super.initState();
    _precioController = TextEditingController();

    _textField = [
      TxtContent(
        id: 0,
        title: "Precio",
        textEditingController: _precioController,
        textInputType: TextInputType.phone,
      ),
    ];
  }

  @override
  void dispose() {
    _precioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _provider.balance(),
        builder: (_, AsyncSnapshot<List<ListaModel>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return Column(
              children: [
                ..._textField.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TxtCodika(
                      txtController: e.textEditingController,
                      isBorder: true,
                      label: e.title,
                      inputType: e.textInputType,
                      txtRadiusBorder: 4,
                      containerPadding: EdgeInsets.all(10),
                      preffix: e.id == 0
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Text("Modificar"),
                      ),
                    ),
                    onTap: () async {
                      setState(() {
                        snapshot.data[0].precio =
                            int.parse(_precioController.text);
                      });
                      await _provider.modificarBalance(snapshot.data[0]);

                      Navigator.of(context).pushAndRemoveUntil(
                        FadeRoute(
                          page: Home(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
                Spacer(),
                PrecioTotal(
                  balance:
                      "RD\$ ${numberFormat.format(snapshot.data[0].precio)}",
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
