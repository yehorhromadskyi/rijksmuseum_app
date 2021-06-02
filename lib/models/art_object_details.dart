class ArtObjectDetails {
  String description;
  String plaqueDescriptionDutch;
  String plaqueDescriptionEnglish;
  String fullImageUrl;

  ArtObjectDetails(this.description);

  ArtObjectDetails.fromJson(
    Map<String, dynamic> json,
  )   : description = json['description'],
        fullImageUrl = json['webImage']['url'],
        plaqueDescriptionDutch = json['plaqueDescriptionDutch'],
        plaqueDescriptionEnglish = json['plaqueDescriptionEnglish'];
}
