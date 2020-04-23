class UserDetails {
  int id;
  String name;
  String url;


  UserDetails({
    this.id,
    this.name,
    this.url
  });

  factory UserDetails.fromJson(Map<String, dynamic> json)
  {
    return UserDetails(
      id: json['id'],
      name: json["login"],
      url: json["avatar_url"],

    );
  }
}

class FollowDetails {
  int id;
  String name;
  String url;


  FollowDetails({
    this.id,
    this.name,
    this.url
  });

  factory FollowDetails.fromJson(Map<String, dynamic> json)
  {
    return FollowDetails(
      id: json['id'],
      name: json["login"],
      url: json["avatar_url"],

    );
  }


}