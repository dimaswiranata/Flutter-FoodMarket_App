import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foodmarket/models/models.dart';
import 'package:flutter_foodmarket/services/services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState>{
  UserCubit() : super(UserInitial());

  Future<void> signIn(String email, String password) async {
    ApiReturnValue<User> result = await UserServices.signIn(email, password);

    if(result.value != null){
      emit(UserLoaded(result.value)); // Apabila result mempunyai data maka disimpan di UserLoaded
    } else { 
      // Jika result tidak mempunyai data maka, menerima pesan kegagalan dan pesan kegagalan 
      // disimpan di UserLoadingFailed
      emit(UserLoadingFailed(result.message));
    }
  }

  // menghubungkan dari service ke UI method signUp di user_services.dart
  Future<void> signUp(User user, String password, {File pictureFile}) async {
    // hasil method signUp diseimpan ke result
    ApiReturnValue<User> result = await UserServices.signUp(user, password, pictureFile: pictureFile);

    if(result.value != null){
      emit(UserLoaded(result.value)); // Apabila result mempunyai data maka disimpan di UserLoaded
    } else { 
      // Jika result tidak mempunyai data maka, menerima pesan kegagalan dan pesan kegagalan 
      // disimpan di UserLoadingFailed
      emit(UserLoadingFailed(result.message));
    }
  }

  // menghubungkan dari service ke UI method uploadProfilePicture di user_services.dart
  Future<void> uploadProfilePicture(File pictureFile) async {
    // hasil method uploadProfilePicture berupa string disimpan ke result
    ApiReturnValue<String> result = await UserServices.uploadProfilePicture(pictureFile);

    if(result.value != null){
      // Apabila result mempunyai data picturePath maka disimpan di UserLoaded.user.picturePath dengan method copyWith
      emit(UserLoaded((state as UserLoaded).user.copyWith(picturePath : "http://foodmarket-backend.test/storage/" + result.value))); 
    } else { 
      // Jika result tidak mempunyai data maka, menerima pesan kegagalan dan pesan kegagalan 
      // disimpan di UserLoadingFailed
      emit(UserLoadingFailed(result.message));
    }
  }
  
}