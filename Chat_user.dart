class ChatUser {
  ChatUser({
    required this.image,
    required this.LastActive,
    required this.name,
    required this.about,
    required this.PushToken,
    required this.isOnline,
    required this.id,
    required this.email,
    required this.CreatedAt,
  });
  late final String image;
  late final String LastActive;
  late final String name;
  late final String about;
  late final String PushToken;
  late final bool isOnline;
  late final String id;
  late final String email;
  late final String CreatedAt;

  ChatUser.fromJson(Map<String, dynamic> json){
    image = json['image'] ;
    LastActive = json['Last_active'] ?? '';
    name = json['name']?? '';
    about = json['about']?? '';
    PushToken = json['Push_token']?? '';
    isOnline = json['isOnline']?? '';
    id = json['id']?? '';
    email = json['email']?? '';
    CreatedAt = json['Created_at']?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['Last_active'] = LastActive;
    data['name'] = name;
    data['about'] = about;
    data['Push_token'] = PushToken;
    data['isOnline'] = isOnline;
    data['id'] = id;
    data['email'] = email;
    data['Created_at'] = CreatedAt;
    return data;
  }
}