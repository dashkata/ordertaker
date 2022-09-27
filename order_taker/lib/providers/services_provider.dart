import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_services.dart';
import '../services/user_services.dart';

final userServicesProvider = Provider<UserServices>(UserServices.new);
final storageServicesProvider = Provider<StorageServices>(StorageServices.new);
