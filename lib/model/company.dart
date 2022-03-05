class Company {
  Company({
    required this.id,
    required this.username,
    required this.password,
    this.profileImage,
    this.coverImage,
    required this.title,
  });
  late final int id;
  late final String username;
  late final String password;
  late final String? profileImage;
  late final String? coverImage;
  late final String title;

  Company.fromJson(Map<String, dynamic> json){
    id = json['id'];
    username = json['username'];
    password = json['password'];
    profileImage = json['profile_image'];
    coverImage = json['cover_image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['password'] = password;
    _data['profile_image'] = profileImage;
    _data['cover_image'] = coverImage;
    _data['title'] = title;
    return _data;
  }
}