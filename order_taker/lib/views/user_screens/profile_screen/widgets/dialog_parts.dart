import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/enums/image_type.dart';
import 'package:order_taker/providers/controller_providers.dart';

class DialogTitle extends StatelessWidget {
  const DialogTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text.choose_an_option,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}

class DialogContent extends ConsumerWidget {
  const DialogContent({
    Key? key,
    required this.text,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: ListBody(
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: Text(text.camera),
            onTap: () =>
                ref.read(userProfileProvider.notifier).changeProfileImage(
                      context,
                      ImageTypes.camera,
                    ),
          ),
          ListTile(
            leading: const Icon(Icons.browse_gallery),
            title: Text(text.browse_gallery),
            onTap: () =>
                ref.read(userProfileProvider.notifier).changeProfileImage(
                      context,
                      ImageTypes.gallery,
                    ),
          ),
        ],
      ),
    );
  }
}
