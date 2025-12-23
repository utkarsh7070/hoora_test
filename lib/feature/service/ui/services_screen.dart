import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoora_test/feature/service/ui/service_tile.dart';

import '../../../core/models/service.dart';
import '../providers/service_providers.dart';

class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({super.key});


  @override
  ConsumerState createState() => _ServicesScreenState();
}


class _ServicesScreenState extends ConsumerState<ServicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;


  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(servicesProvider);
    final favorites = ref.watch(favoritesProvider);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        bottom: TabBar(
          controller: controller,
          tabs: const [
            Tab(text: 'All Services'),
            Tab(text: 'Favorites'),
          ],
        ),
      ),
      body: servicesAsync.when(
        data: (services) => TabBarView(
          controller: controller,
          children: [
            _buildList(services),
            _buildList(
              services.where((s) => favorites.contains(s.id)).toList(),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text(e.toString()),
      ),
    );
  }


  Widget _buildList(List<Service> services) {
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (_, index) => ServiceTile(service: services[index]),
    );
  }
}