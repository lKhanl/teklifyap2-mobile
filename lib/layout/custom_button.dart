import 'package:flutter/material.dart';
import 'package:teklifyap_mobil2/style/colors.dart';

class CustomButton extends StatefulWidget implements PreferredSizeWidget {
  const CustomButton(
      {super.key, required this.title, this.onPressed, this.color});

  final String title;
  final Function? onPressed;
  final Color? color;

  @override
  State<CustomButton> createState() => _CustomButtonState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomButtonState extends State<CustomButton> {
  late Function? onPressed;
  late String title;
  late Color color;

  @override
  void initState() {
    super.initState();
    setState(() {
      onPressed = widget.onPressed;
      color = widget.color ?? Colors.black;
      title = widget.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed!();
      },
      style: ElevatedButton.styleFrom(
        primary: ThemeColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(color: color),
      ),
    );
  }
}
