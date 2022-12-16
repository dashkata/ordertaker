part of '../profile.dart';

class _ContainerPicture extends StatelessWidget {
  const _ContainerPicture({
    Key? key,
    required this.text,
  }) : super(key: key);

  final AppLocalizations text;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              color: complementaryColor2,
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
              const CustomProfilePicture(
                radius: 60,
              ),
              Consumer(
                builder: (_, ref, child) => IconButton(
                  style: IconButton.styleFrom(
                    side: const BorderSide(
                      width: 1.5,
                    ),
                  ),
                  icon: const Icon(
                    Icons.camera_alt,
                    color: accentBlackColor,
                  ),
                  onPressed: () =>
                      ref.read(userProfileProvider.notifier).showPicDialog(
                            _DialogTitle(text: text),
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
