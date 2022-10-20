import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Themes/themes.dart';
import '../../project_widgets.dart';
import 'controllers/edit_accounts_providers.dart';

part 'widgets/account_alert_dialog.dart';

class EditRestaurantAccounts extends ConsumerWidget {
  const EditRestaurantAccounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
        ),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            const BackgroundWidget(),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: NormalButtons(
                      buttonText: 'Add an account',
                      buttonFunc: () => showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: _AlertDialogTitle(),
                          content: _AlertDialogBody(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
