import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/service.dart';
import '../providers/service_providers.dart';

class ServiceTile extends ConsumerWidget {
  final Service service;


  const ServiceTile({super.key, required this.service});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final hive = ref.read(hiveProvider);


    final isFav = favorites.contains(service.id);


    return ListTile(
      title: Text(service.name),
      trailing: IconButton(
        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          hive.toggleFavorite(service.id);
          ref.read(favoritesProvider.notifier).state =
              hive.getFavorites().toSet();
        },
      ),
    );
  }
}