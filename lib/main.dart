import 'package:flutter/material.dart';

import 'router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Monedero());
}

class Monedero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Monedero',
      home: Home(),
      theme: ThemeData(
        primaryColor: Color(0xFFEB9622),
      ),
    );
  }
}
