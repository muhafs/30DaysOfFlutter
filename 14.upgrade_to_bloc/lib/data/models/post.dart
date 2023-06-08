class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({this.title, this.body, this.id, this.userId});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );
}
