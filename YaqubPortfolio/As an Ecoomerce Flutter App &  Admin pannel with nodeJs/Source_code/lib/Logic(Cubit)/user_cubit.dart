import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:clone/Models/user.dart';
import 'package:meta/meta.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserInitial> {
  UserCubit() : super(UserInitial( token: '', user: User()));
  User userObj = User();

  emitToken(String user) {
    userObj = User.fromJson(user);
    emit(UserInitial(user: userObj , token: userObj.token ?? ''));
  }

  emitUserCartUpdated(User user){
    emit(UserInitial(user: user, token: user.token.toString()));
  }
}

