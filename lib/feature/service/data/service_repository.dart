import '../../../core/models/service.dart';
import '../../../core/network/api_client.dart';

class ServiceRepository {
  final ApiClient api;


  ServiceRepository(this.api);


  Future<List<Service>> getServices() => api.fetchServices();
}