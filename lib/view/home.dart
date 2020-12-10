import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monedero/router/router.dart';
import 'package:monedero/util/sizes.dart';
import 'package:monedero/view/balance.dart';
import 'package:monedero/view/registrar.dart';
import 'package:monedero/widgets/precio_total.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<_Botones> _botones = [
    _Botones(
      id: 0,
      nombre: "Balance",
      icon: FontAwesomeIcons.handHoldingUsd,
    ),
    _Botones(
      id: 1,
      nombre: "Agregar",
      icon: FontAwesomeIcons.layerGroup,
    ),
    _Botones(
      id: 2,
      nombre: "Lista",
      icon: FontAwesomeIcons.listAlt,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SmartRefresher(
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _botones.map((e) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Sizes(30).sizes(context),
                      ),
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Icon(
                                e.icon,
                                color: Theme.of(context).primaryColor,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                e.nombre,
                                style: textos(
                                  ctn: context,
                                  color: Theme.of(context).primaryColor,
                                  fSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => _funcion(context, e.id),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            _total(context),
          ],
        ),
      ),
    );
  }

  Widget _total(BuildContext context) {
    return PrecioTotal();
  }

  void _funcion(BuildContext context, int id) {
    if (id == 0) {
      Navigator.of(context).push(
        FadeRoute(
          page: Balance(),
        ),
      );
    } else if (id == 1) {
      Navigator.of(context).push(
        FadeRoute(
          page: Agregar(),
        ),
      );
    } else if (id == 2) {
      Navigator.of(context).push(
        FadeRoute(
          page: Lista(),
        ),
      );
    }
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {});
    _refreshController.refreshCompleted();
  }
}

class _Botones {
  final int id;
  final String nombre;
  final IconData icon;

  _Botones({
    this.id,
    this.nombre,
    this.icon,
  });
}
