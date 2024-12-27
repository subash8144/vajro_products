class Product {
  List<Articles>? articles;
  String? status;

  Product({this.articles, this.status});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Articles {
  int? id;
  String? title;
  String? createdAt;
  String? bodyHtml;
  int? blogId;
  String? author;
  int? userId;
  String? publishedAt;
  String? updatedAt;
  String? summaryHtml;
  String? templateSuffix;
  String? handle;
  String? tags;
  String? adminGraphqlApiId;
  ImageProperty? image;

  Articles(
      {this.id,
        this.title,
        this.createdAt,
        this.bodyHtml,
        this.blogId,
        this.author,
        this.userId,
        this.publishedAt,
        this.updatedAt,
        this.summaryHtml,
        this.templateSuffix,
        this.handle,
        this.tags,
        this.adminGraphqlApiId,
        this.image});

  Articles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    bodyHtml = json['body_html'];
    blogId = json['blog_id'];
    author = json['author'];
    userId = json['user_id'];
    publishedAt = json['published_at'];
    updatedAt = json['updated_at'];
    summaryHtml = json['summary_html'];
    templateSuffix = json['template_suffix'];
    handle = json['handle'];
    tags = json['tags'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
    image = json['image'] != null ? ImageProperty.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['body_html'] = bodyHtml;
    data['blog_id'] = blogId;
    data['author'] = author;
    data['user_id'] = userId;
    data['published_at'] = publishedAt;
    data['updated_at'] = updatedAt;
    data['summary_html'] = summaryHtml;
    data['template_suffix'] = templateSuffix;
    data['handle'] = handle;
    data['tags'] = tags;
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class ImageProperty {
  String? createdAt;
  String? alt;
  int? width;
  int? height;
  String? src;

  ImageProperty({this.createdAt, this.alt, this.width, this.height, this.src});

  ImageProperty.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    alt = json['alt'];
    width = json['width'];
    height = json['height'];
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['alt'] = alt;
    data['width'] = width;
    data['height'] = height;
    data['src'] = src;
    return data;
  }
}