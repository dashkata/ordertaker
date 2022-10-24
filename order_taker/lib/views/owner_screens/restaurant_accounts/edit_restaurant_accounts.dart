import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Themes/themes.dart';
import '../../custom_widgets/custom_alert_dialog.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_drawer.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../project_widgets.dart';
import 'controllers/edit_accounts_providers.dart';

part 'widgets/account_alert_dialog.dart';

class EditRestaurantAccounts extends ConsumerWidget {
  const EditRestaurantAccounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Accounts',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        drawer: const CustomDrawer(),
        backgroundColor: mainColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CustomButton(
                  buttonText: 'Add an account',
                  buttonFunc: () => showDialog(
                    context: context,
                    builder: (context) => const CustomAlertDialog(
                      title: _AlertDialogTitle(),
                      content: _AlertDialogBody(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
