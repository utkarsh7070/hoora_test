

import '../models/service.dart';

class ApiClient {
  Future<List<Service>> fetchServices() async {
    await Future.delayed(const Duration(seconds: 1));


    return List.generate(
      1000,
          (index) => Service(id: index, name: 'Service $index'),
    );
  }
}