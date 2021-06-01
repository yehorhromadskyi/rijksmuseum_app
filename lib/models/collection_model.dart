import 'package:flutter/material.dart';
import 'package:rijksmuseum_app/models/art_object.dart';
import 'package:rijksmuseum_app/services/api_service.dart';

class CollectionModel extends ChangeNotifier {
  List<ArtObject> artObjects = [];

  Future load() async {
    var service = ApiService();
    var items = await service.get();
    var artObjects = (items['artObjects'] as List<dynamic>)
        .map((e) => ArtObject.fromJson(e))
        .toList();

    this.artObjects = artObjects;

    notifyListeners();
  }
}
