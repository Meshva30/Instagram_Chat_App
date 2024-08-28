
class UserModel {
  String? name, phone, email, photourl;

  UserModel(
      {required this.name,
      required this.phone,
      required this.email,
      required this.photourl});

  factory UserModel.fromMap(Map m1) {
    return UserModel(
        name: m1['name'],
        phone: m1['phone'],
        email: m1['email'],
        photourl: m1['photourl']);
  }
  Map<String, String?> toMap(UserModel user)
  {
    return{
      'name':user.name,
      'phone':user.phone,
      'email':user.email,
      'photourl':user.photourl,
    };
  }
}
