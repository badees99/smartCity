import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;

  final String name, eMail, password, job;

  const User(
      {required this.id,
      required this.name,
      required this.eMail,
      required this.password,
      required this.job});

  @override
  // TODO: implement props
  List<Object?> get props => [name, eMail, password, job, id];
}
