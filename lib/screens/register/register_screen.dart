import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teklifyap_mobil2/screens/login/login_screen.dart';

import '../../layout/custom_app_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String name;
  late String surname;
  late String email;
  late String password;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late FocusNode isClickedEmail = FocusNode();
  late FocusNode isClickedPassword = FocusNode();
  late FocusNode isClickedName = FocusNode();
  late FocusNode isClickedSurname = FocusNode();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(title: "teklifyap",),
      ),
      body: Center(
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm(){
    return Form(
      key: _formKey,
      child:
      Padding(
        padding: const EdgeInsets.all(65),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(

                  prefixIcon: const Icon(Icons.person_rounded,color: Colors.black38,),
                  labelText: "Name",
                  labelStyle: TextStyle(
                      color: isClickedName.hasFocus ?  Colors.green : Colors.black38
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter],
                focusNode: isClickedName,
                onChanged: (value) {
                  // _setPhoneNumber(value);
                  // _onChanged(value);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: _surnameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_rounded,color: Colors.black38),
                  labelText: "Surname",
                  labelStyle: TextStyle(
                      color: isClickedSurname.hasFocus ?  Colors.green : Colors.black38
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter],
                focusNode: isClickedSurname,
                onChanged: (value) {
                  // _setPhoneNumber(value);
                  // _onChanged(value);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(

                  prefixIcon: const Icon(Icons.email_rounded,color: Colors.black38,),
                  labelText: "Email",
                  labelStyle: TextStyle(
                      color: isClickedEmail.hasFocus ?  Colors.green : Colors.black38
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter],
                focusNode: isClickedEmail,
                onChanged: (value) {
                  // _setPhoneNumber(value);
                  // _onChanged(value);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 65),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password_rounded,color: Colors.black38),
                  labelText: "Password",
                  labelStyle: TextStyle(
                      color: isClickedPassword.hasFocus ?  Colors.green : Colors.black38
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.green
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter],
                focusNode: isClickedPassword,
                onChanged: (value) {
                  // _setPhoneNumber(value);
                  // _onChanged(value);
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                name = _nameController.text;
                surname = _surnameController.text;
                email= _emailController.text;
                password = _passwordController.text;
                Get.offAll(() => const LoginScreen());

              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(130, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: const Text('Register',style: TextStyle(color: Colors.black)),

            )          ],
        ),
      ),
    );
  }
}
