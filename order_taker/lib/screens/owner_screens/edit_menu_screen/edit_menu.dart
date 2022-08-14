import 'package:flutter/material.dart';
import 'package:order_taker/screens/project_widgets.dart';

class EditMenu extends StatelessWidget {
  const EditMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          BackgroundWidget(),
          SafeArea(
            child: Text("Helloooo"),
          ),
        ],
      ),
    );
  }
}
