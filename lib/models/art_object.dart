class ArtObject {
  String title;

  ArtObject(this.title);

  ArtObject.fromJson(
    Map<String, dynamic> json,
  ) : title = json['title'];

  Map<String, dynamic> toJson() => {
        'title': title,
      };
}
