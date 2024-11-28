
class CommentModel {
    int? postId;
    int? id;
    String? name;
    String? email;
    String? body;

    CommentModel({
        this.postId,
        this.id,
        this.name,
        this.email,
        this.body,
    });

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
    };
}
