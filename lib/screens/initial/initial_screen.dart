import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teklifyap_mobil2/screens/login/login_screen.dart';
import 'package:teklifyap_mobil2/screens/register/register_screen.dart';


class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Text(
          "teklifyap",
          style: TextStyle(color: Colors.black
          ),
        ),

        const Padding(
            padding: EdgeInsets.all(40)
        ),

        ElevatedButton(
          onPressed: () {
            Get.offAll(() => const LoginScreen());
          },
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(130, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          child: const Text('Sign In',style: TextStyle(color: Colors.black)),

        ),


        const Padding(
            padding: EdgeInsets.all(10)
        ),

        ElevatedButton(
          onPressed: () {
            Get.offAll(() => const RegisterScreen());
          },
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(130, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          child: const Text('Register',style: TextStyle(color: Colors.black)),

        )       ],
    );
  }
}
