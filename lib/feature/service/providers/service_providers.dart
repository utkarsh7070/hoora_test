import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/service.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/hive_service.dart';
import '../data/service_repository.dart';

final apiProvider = Provider((ref) => ApiClient());


final repositoryProvider = Provider(
      (ref) => ServiceRepository(ref.read(apiProvider)),
);


final servicesProvider = FutureProvider<List<Service>>((ref) async {
  return ref.read(repositoryProvider).getServices();
});


final hiveProvider = Provider((ref) => HiveService());


final favoritesProvider = StateProvider<Set<int>>((ref) {
  final hive = ref.read(hiveProvider);
  return hive.getFavorites().toSet();
});