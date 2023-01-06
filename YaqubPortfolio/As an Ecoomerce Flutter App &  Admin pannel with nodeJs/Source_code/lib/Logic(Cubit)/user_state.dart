part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {

  final User user;
  final String token;
  UserInitial({required this.user , required this.token });
}

