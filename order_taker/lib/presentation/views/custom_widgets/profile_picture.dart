import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/presentation/providers/repository_providers.dart';

class CustomProfilePicture extends ConsumerWidget {
  const CustomProfilePicture({
    required this.radius,
    Key? key,
  }) : super(key: key);
  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoURL =
        ref.watch(authRepositoryProvider).getCurrentUser()?.photoURL;
    if (photoURL != null) {
      return CachedNetworkImage(
        imageUrl: photoURL,
        imageBuilder: (context, url) => CircleAvatar(
          backgroundImage: url,
          radius: radius,
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundImage: const AssetImage('assets/noavatar.png'),
          radius: radius,
        ),
      );
    }
    return CircleAvatar(
      backgroundImage: const AssetImage('assets/noavatar.png'),
      radius: radius,
    );
  }
}
