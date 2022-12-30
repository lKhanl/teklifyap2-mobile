import 'package:flutter/material.dart';
import 'package:teklifyap_mobil2/enums/bottom_app_bar_type.dart';
import 'package:teklifyap_mobil2/layout/custom_app_bar.dart';

import '../../layout/custom_bottom_app_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.email, required this.password});

  //deneme amaçlı koyuldu
  final String email;
  final String password;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Teklifyap"),
      bottomNavigationBar:
          const CustomBottomAppBar(from: BottomAppBarType.home),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            //deneme amaçlı koyuldu
            Text(
              widget.email,
            ),
            Text(
              widget.password,
            ),
          ],
        ),
      ),
    );
  }
}
