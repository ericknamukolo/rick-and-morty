import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/constants/constants.dart';
import 'package:rick_and_morty/models/character.dart';

class RADCharacters with ChangeNotifier {
  List<RADCharacter> _characters = [];
  List<RADCharacter> get availableCharacters => _characters;

  Future<void> fetchCharacters(int pageNum) async {
    String url = baseUrl + '/character?page=$pageNum';

    http.Response response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);
    List<RADCharacter> _loaded = [];
    data['results'].forEach((char) {
      _loaded.add(RADCharacter(
        id: char['id'],
        name: char['name'],
        imgUrl: char['image'],
        status: char['status'],
        gender: char['gender'],
      ));
    });
    _characters = _loaded;
    notifyListeners();
  }
}
