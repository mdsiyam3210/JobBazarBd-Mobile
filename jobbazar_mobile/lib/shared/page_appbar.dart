import 'package:flutter/material.dart';
import 'package:jobbazar_mobile/shared/wrapper/gradient_wrapper.dart';

class PageAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const PageAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true, // Ensures the Drawer icon aligns correctly
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 30,
      ),
      backgroundColor: Colors.transparent,
      elevation: 4,
      toolbarHeight: 80,
      flexibleSpace: const GradientWrapper(),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
      centerTitle: true, // Centers the title
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40);
}
