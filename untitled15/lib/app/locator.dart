import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/characters_model.dart';
import '../services/api_service.dart';
import '../services/preferences_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<PreferencesService>(
          () => PreferencesService(prefs: prefs));

  locator.registerLazySingleton<ApiService>(() => ApiService());
}