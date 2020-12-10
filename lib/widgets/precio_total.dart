import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monedero/models/lista_model.dart';
import 'package:monedero/servicio/servicios.dart';
import 'package:monedero/util/sizes.dart';

// ignore: must_be_immutable
class PrecioTotal extends StatelessWidget {
  String balance;
  PrecioTotal({
    this.balance,
  });
  final _provider = Servicios();
  NumberFormat numberFormat = NumberFormat('#,##0.00');
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: FutureBuilder(
          future: _provider.lista(),
          builder: (_, AsyncSnapshot<List<ListaModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
              );
            }
            return Center(
              child: Text(
                balance != null
                    ? balance.toString()
                    : "RD\$ ${numberFormat.format(double.parse(_returnTotalAmount(snapshot.data)))}",
                style: textos(
                  ctn: context,
                  fontWeight: FontWeight.w500,
                  fSize: 20,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _returnTotalAmount(List<ListaModel> carrito) {
    int totalAmount = 0;
    for (int i = 0; i < carrito.length; i++) {
      totalAmount += carrito[i].precio;
    }

    return totalAmount.toString();
  }
}
