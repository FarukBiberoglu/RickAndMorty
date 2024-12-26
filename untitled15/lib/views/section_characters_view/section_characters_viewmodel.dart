import 'package:flutter/foundation.dart';

import '../../app/locator.dart';
import '../../models/characters_model.dart';
import '../../models/episode_model.dart';
import '../../services/api_service.dart';


class SectionCharactersViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<CharacterModel> _characters = [];
  List<CharacterModel> get characters => _characters;

  void getCharacters(EpisodeModel episodeModel) async {
    _characters =
    await _apiService.getCharactersFromUrlList(episodeModel.characters);
    notifyListeners();
  }
}