class ArtObject {
  String title;
  String headerImageUrl;

  ArtObject(this.title, this.headerImageUrl);

  ArtObject.fromJson(
    Map<String, dynamic> json,
  )   : title = json['title'],
        headerImageUrl = json['headerImage']['url'];
}
