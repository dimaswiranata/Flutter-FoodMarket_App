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
  
}