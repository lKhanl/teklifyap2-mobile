import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final Icon? prefixIcon;
  final Color? color;
  final String placeholder;
  final bool? isPassword;
  final Function? onChange;
  final TextEditingController? controller;

  const CustomTextField(
      {super.key,
      required this.placeholder,
      this.color,
      this.isPassword,
      this.onChange,
      this.controller,
      this.prefixIcon});

  @override
  State<StatefulWidget> createState() {
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  late String placeholder;
  late bool isPassword = false;
  late Color color;
  late Function? onChange;
  late Icon? icon;


  @override
  void initState() {
    super.initState();
    color = widget.color ?? Colors.black38;
    placeholder = widget.placeholder;
    isPassword = widget.isPassword ?? false;
    onChange = widget.onChange;
    icon = widget.prefixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: TextField(
        onChanged: (value) {
          onChange!(value);
        },
        cursorColor: color,
        obscureText: isPassword,
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: icon,
          prefixIconColor: color,
          labelText: placeholder,
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          hoverColor: color,
          focusColor: color,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
