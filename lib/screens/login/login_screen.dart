import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../layout/custom_app_bar.dart';
import '../home/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late FocusNode isClickedEmail = FocusNode();

  late FocusNode isClickedPassword = FocusNode();




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
                onSubmitted: (value) {
                  email = value;
                },
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
                onSubmitted: (value) {password=value;},
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
                email= _emailController.text;
                password= _passwordController.text;
                Get.offAll(() =>  Home(email: email,password: password,));

              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(130, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: const Text('Sign In',style: TextStyle(color: Colors.black)),

            )
          ],
        ),
      ),
    );
  }


// void _continueButton(){
//   Navigator.of(context).pushReplacementNamed(
//     WelcomeScreen.route,
//     arguments: "Guest",
//   );
// }

// void _validate(){
//   final form = _formKey.currentState;
//   if(!form!.validate()){
//     return;
//   }
//   final phoneNumber= _phoneNumberController.text;
//   if(charLength == 14){
//     Navigator.of(context).pushReplacementNamed(
//       SmsScreen.route,
//       arguments: phoneNumber,
//     );
//   }
//   else{
//     return;
//   }
// }

// void _setPhoneNumber(value){
//   phoneNumber = value;
// }

}

