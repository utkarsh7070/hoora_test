import 'package:hive/hive.dart';

class HiveService {
  final Box box = Hive.box('favorites');


  bool isFavorite(int id) => box.get(id.toString(), defaultValue: false);

  void addFavorite(int serviceId) {
    box.put(serviceId.toString(), true);
  }

  void removeFavorite(int serviceId) {
    box.delete(serviceId.toString());
  }
  void toggleFavorite(int serviceId) {
    if (isFavorite(serviceId)) {
      removeFavorite(serviceId);
    } else {
      addFavorite(serviceId);
    }
  }


  List<int> getFavorites() {
    return box.keys.map((e) => int.parse(e)).toList();
  }
}