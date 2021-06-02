import 'package:flutter/foundation.dart';
import 'package:rijksmuseum_app/models/art_object.dart';
import 'package:rijksmuseum_app/services/api_service.dart';

class CollectionModel extends ChangeNotifier {
  ApiService _apiService;

  CollectionModel(this._apiService);

  List<ArtObject> _artObjects = [];
  List<ArtObject> get artObjects => _artObjects;

  int _page;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future load() async {
    _isLoading = true;
    _page = 1;

    List<ArtObject> newArtObjects = await _fetchCollection(_page);
    _artObjects = newArtObjects;

    notifyListeners();
    _isLoading = false;
  }

  Future loadMore() async {
    _isLoading = true;
    _page++;

    List<ArtObject> newArtObjects = await _fetchCollection(_page);
    _artObjects.addAll(newArtObjects);

    notifyListeners();
    _isLoading = false;
  }

  Future<List<ArtObject>> _fetchCollection(int page) async {
    try {
      var response = await _apiService.fetchCollection(page: page);

      List<ArtObject> artObjects = (response['artObjects'] as List<dynamic>)
          .map((e) => ArtObject.fromJson(e))
          .toList();

      return artObjects;
    } catch (e) {
      // log exception
      // distinguish between FetchException and any other type of Exception
      return [];
    }
  }
}
