import 'package:flutter/material.dart';

class CustomActionButton extends StatefulWidget implements PreferredSizeWidget {
  const CustomActionButton(
      {super.key, required this.icon, this.onPressed, this.color});

  final IconData icon;
  final Function? onPressed;
  final Color? color;

  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomActionButtonState extends State<CustomActionButton> {
  late Function? onPressed;
  late IconData icon;
  late Color color;

  @override
  void initState() {
    super.initState();
    setState(() {
      onPressed = widget.onPressed;
      color = widget.color ?? Colors.black;
      icon = widget.icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed!();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
