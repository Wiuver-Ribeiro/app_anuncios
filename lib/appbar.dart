import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: null,
        flexibleSpace: const Center(
            child: Image(
          image: AssetImage("images/logo.png"),
        )),
        backgroundColor: const Color(0xFFFFD200),
      ),
    );
  }
}
