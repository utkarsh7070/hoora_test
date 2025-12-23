import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hoora_test/core/storage/hive_service.dart';

void main() {
  late HiveService hiveService;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final Directory tempDir = Directory.systemTemp.createTempSync();
    Hive.init(tempDir.path);
    await Hive.openBox('favorites');

    hiveService = HiveService();
  });

  tearDown(() async {
    await Hive.box('favorites').clear();
  });

  test('adds favorite', () {
    hiveService.addFavorite(1);

    expect(hiveService.isFavorite(1), true);
  });

  test('removes favorite', () {
    hiveService.addFavorite(2);
    hiveService.removeFavorite(2);

    expect(hiveService.isFavorite(2), false);
  });

  test('toggle favorite works', () {
    hiveService.toggleFavorite(3);
    expect(hiveService.isFavorite(3), true);

    hiveService.toggleFavorite(3);
    expect(hiveService.isFavorite(3), false);
  });
}
