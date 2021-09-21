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
        title: json["title"],
        url: json["url"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "description": description,
      };
}
