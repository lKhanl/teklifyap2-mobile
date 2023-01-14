import 'package:flutter/material.dart';
import 'package:teklifyap_mobil2/style/colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late List<Widget> actions;

  @override
  void initState() {
    super.initState();
    actions = widget.actions ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ThemeColors.primaryColor,
      title: Text(widget.title, style: const TextStyle(color: Colors.black)),
      centerTitle: true,
      actions: actions,
    );
  }
}
