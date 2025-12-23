import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hoora_test/core/storage/hive_service.dart';
import 'package:hoora_test/feature/service/providers/service_providers.dart';

void main() {
  late FavoritesNotifier notifier;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // ✅ Use system temp directory (VM-safe)
    final Directory tempDir = Directory.systemTemp.createTempSync();
    Hive.init(tempDir.path);

    await Hive.openBox('favorites');

    notifier = FavoritesNotifier(HiveService());
  });

  tearDown(() async {
    await Hive.box('favorites').clear();
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('initial state is empty', () {
    expect(notifier.state.isEmpty, true);
  });

  test('toggle adds favorite', () {
    notifier.toggle(10);

    expect(notifier.state.contains(10), true);
  });

  test('toggle removes favorite', () {
    notifier.toggle(20);
    notifier.toggle(20);

    expect(notifier.state.contains(20), false);
  });
}
