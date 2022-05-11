import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordChangeProvider = StateProvider((ref) => false);

final nameChangeProvider = StateProvider((ref) => false);

final emailChangeProvider = StateProvider((ref) => false);

final phoneChangeProvider = StateProvider((ref) => false);

final changeControllerProvider = StateProvider.autoDispose((ref) => '');

final messageProvider = StateProvider.autoDispose((ref) => '');
