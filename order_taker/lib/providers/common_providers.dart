import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_taker/services/firestore_services.dart';
import 'package:order_taker/services/storage_services.dart';

final databaseProvider = Provider<DatabaseService>((ref) => DatabaseService());
final storageProvider = Provider<StorageServices>((ref) => StorageServices());
