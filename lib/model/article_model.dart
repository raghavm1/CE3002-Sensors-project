class ArticleModel {
  String title;
  String url;
  String description;

  ArticleModel({
    required this.title,
    required this.url,
    required this.description,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "description": description == null ? null : description,
      };
}
