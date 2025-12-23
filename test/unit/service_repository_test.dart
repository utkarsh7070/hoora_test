import 'package:flutter_test/flutter_test.dart';
import 'package:hoora_test/core/models/service.dart';
import 'package:hoora_test/core/network/api_client.dart';
import 'package:hoora_test/feature/service/data/service_repository.dart';

class FakeApiClient extends ApiClient {
  @override
  Future<List<Service>> fetchServices() async {
    return [
      Service(id: 1, name: 'Service A'),
      Service(id: 2, name: 'Service B'),
    ];
  }
}

void main() {
  late ServiceRepository repository;

  setUp(() {
    repository = ServiceRepository(FakeApiClient());
  });

  test('returns list of services from API', () async {
    final services = await repository.getServices();

    expect(services.length, 2);
    expect(services.first.name, 'Service A');
  });
}
