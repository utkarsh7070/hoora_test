import 'package:hive/hive.dart';

class HiveService {
  final Box box = Hive.box('favorites');


  bool isFavorite(int id) => box.get(id.toString(), defaultValue: false);


  void toggleFavorite(int id) {
    box.put(id.toString(), !isFavorite(id));
  }


  List<int> getFavorites() {
    return box.keys.map((e) => int.parse(e)).toList();
  }
}