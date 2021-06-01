import 'package:flutter/foundation.dart';
import 'package:rijksmuseum_app/models/art_object.dart';
import 'package:rijksmuseum_app/services/api_service.dart';

class CollectionModel extends ChangeNotifier {
  ApiService _apiService;

  CollectionModel(this._apiService);

  List<ArtObject> _artObjects = [];
  List<ArtObject> get artObjects => _artObjects;

  int _page = 0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future load() async {
    _page = 0;
    _isLoading = true;

    var response = await _apiService.get();
    var artObjects = _parseResponse(response);
    _artObjects = artObjects;

    notifyListeners();
    _isLoading = false;
  }

  Future loadMore() async {
    _isLoading = true;
    _page++;

    var response = await _apiService.get(page: _page);
    var artObjects = _parseResponse(response);
    _artObjects.addAll(artObjects);

    notifyListeners();
    _isLoading = false;
  }

  List<ArtObject> _parseResponse(dynamic response) {
    var artObjects = (response['artObjects'] as List<dynamic>)
        .map((e) => ArtObject.fromJson(e))
        .toList();

    return artObjects;
  }
}
