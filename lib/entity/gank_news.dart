class GankNews {
  final String createdAt;
  final String desc;
  final List<dynamic> images;
  final String publishedAt;
  final String url;
  final String who;

  GankNews(this.createdAt, this.desc, this.images, this.publishedAt,
      this.url, this.who);

  GankNews.fromJson(Map<String, dynamic> json)
      :createdAt = json['createdAt'],
       desc = json['desc'],
       images = json['images'],
       publishedAt = json['publishedAt'],
       url = json['url'],
       who = json['who'];
  
  @override
  String toString() {
    final imageString = images.toString();
    return '{desc: $desc, url: $url, createdAt: $createdAt, publishedAt: $publishedAt, who: $who, images: $imageString}';
  }
}