import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/service_providers.dart';
import '../../../core/models/service.dart';

class ServiceTile extends ConsumerWidget {
  final Service service;

  const ServiceTile({super.key, required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesNotifier = ref.read(favoritesProvider.notifier);
    final isFav = ref.watch(favoritesProvider).contains(service.id);

    return ListTile(
      title: Text(service.name),
      trailing: IconButton(
        icon: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? Colors.red : null,
        ),
        onPressed: () {
          favoritesNotifier.toggle(service.id);
        },
      ),
    );
  }
}
