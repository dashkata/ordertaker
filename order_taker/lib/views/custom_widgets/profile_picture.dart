import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../user_screens/profile_screen/controllers/profile_screen_providers.dart';

class CustomProfilePicture extends ConsumerWidget {
  const CustomProfilePicture({
    required this.radius,
    Key? key,
  }) : super(key: key);
  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue picUrl = ref.watch(picProvider);
    return picUrl.when(
      data: (data) => CachedNetworkImage(
        imageUrl: data,
        imageBuilder: (context, url) => CircleAvatar(
          backgroundImage: url,
          radius: radius,
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundImage: const AssetImage('assets/noavatar.png'),
          radius: radius,
        ),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (e, s) => Text('Error $e'),
    );
    // return const Text("Error when loading profile picture");
  }
}
