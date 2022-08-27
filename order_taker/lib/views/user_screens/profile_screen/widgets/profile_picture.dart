import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:order_taker/Themes/themes.dart';
import 'package:order_taker/providers/controller_providers.dart';
import 'package:order_taker/providers/repository_providers.dart';
import 'package:order_taker/views/project_widgets.dart';
import 'package:order_taker/views/user_screens/profile_screen/widgets/dialog_parts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContainerPicture extends StatelessWidget {
  const ContainerPicture({
    Key? key,
    required this.text,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
            color: complementaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(200),
              bottomLeft: Radius.circular(200),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Consumer(
                builder: (context, ref, child) => Text(
                  ref
                      .watch(authRepositoryProvider)
                      .getCurrentUser()!
                      .displayName!,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ),
        ),
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            const ProfilePicture(
              radius: 60,
            ),
            Consumer(
              builder: (_, ref, child) => GFIconButton(
                color: GFColors.WHITE,
                size: GFSize.SMALL,
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
                shape: GFIconButtonShape.circle,
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                onPressed: () =>
                    ref.read(userProfileProvider.notifier).showPicDialog(
                      DialogTitle(text: text),
                      DialogContent(text: text),
                      context,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
