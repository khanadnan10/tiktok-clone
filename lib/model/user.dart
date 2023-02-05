class User {
    User({
        required this.name,
        this.profilePhoto,
        required this.email,
        required this.uid,
    });

    String name;
    String? profilePhoto;
    String email;
    String uid;

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        profilePhoto: json["profilePhoto"],
        email: json["email"],
        uid: json["uid"],
    );


    Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
    };
}
