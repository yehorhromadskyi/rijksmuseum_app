class ArtObject {
  String objectNumber;
  String title;
  String headerImageUrl;

  ArtObject(this.objectNumber, this.title, this.headerImageUrl);

  ArtObject.fromJson(
    Map<String, dynamic> json,
  )   : objectNumber = json['objectNumber'],
        title = json['title'],
        headerImageUrl = json['headerImage']['url'];
}
