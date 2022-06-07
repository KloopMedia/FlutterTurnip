import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? photo;

  const AuthUser({required this.id, this.name, this.email, this.photo});

  static const empty = AuthUser(id: '');

  bool get isEmpty => this == AuthUser.empty;
  bool get isNotEmpty => this != AuthUser.empty;

  @override
  List<Object?> get props => [id, email, name, photo];
}