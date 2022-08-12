import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/repository_providers.dart';
import '../../project_widgets.dart';

class EditMenu extends StatelessWidget {
  const EditMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer(
        builder: (child, ref, context) {
          return FloatingActionButton(onPressed: () {
            ref.read(authRepositoryProvider).signout();
          });
        },
      ),
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
