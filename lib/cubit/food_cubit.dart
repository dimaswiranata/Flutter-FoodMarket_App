import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foodmarket/models/models.dart';
import 'package:flutter_foodmarket/services/services.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState>{
  FoodCubit() : super(FoodInitial());

  Future<void> getFoods() async {
    ApiReturnValue<List<Food>> result = await FoodServices.getFoods();

    if(result.value != null){
      emit(FoodLoaded(result.value)); // Apabila result mempunyai data maka disimpan di FoodLoaded
    } else { 
      // Jika result tidak mempunyai data maka, menerima pesan kegagalan dan pesan kegagalan 
      // disimpan di FoodLoadingFailed
      emit(FoodLoadingFailed(result.message));
    }
  }
  
}