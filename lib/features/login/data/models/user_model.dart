import 'package:smartcity/features/login/domain/entities/user.dart ';

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.name,
      required super.eMail,
      required super.password,
      required super.job});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['uid'],
        name: json['name'],
        eMail: json['email'],
        password: json['password'],
        job: json['job']);
  }

  Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'eMail': user.eMail,
      'password': user.password,
      'job': user.job
    };
  }
}
