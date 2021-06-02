import 'package:flutter/material.dart';
import 'package:rijksmuseum_app/models/art_object_details.dart';
import 'package:rijksmuseum_app/services/api_service.dart';

class DetailsModel extends ChangeNotifier {
  ApiService _apiService;

  DetailsModel(this._apiService);

  String _imageUrl;
  String get imageUrl => _imageUrl;

  String _descriptionDutch;
  String get descriptionDutch => _descriptionDutch;

  String _descriptionEnglish;
  String get descriptionEnglish => _descriptionEnglish;

  Future<ArtObjectDetails> load(String objectNumber) async {
      var response = await _apiService.fetchDetails(objectNumber: objectNumber);

      ArtObjectDetails artObjectDetails =
          ArtObjectDetails.fromJson(response['artObject']);

      _imageUrl = artObjectDetails.fullImageUrl;
      _descriptionDutch = artObjectDetails.plaqueDescriptionDutch;
      _descriptionEnglish = artObjectDetails.plaqueDescriptionEnglish;

      notifyListeners();

      return artObjectDetails;
  }
}
