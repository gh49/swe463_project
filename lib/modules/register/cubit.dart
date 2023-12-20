import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swe463_project/shared/networking.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());

  String? name;
  int selectedGender = 0;

  void setGender(int value) {
    selectedGender = value;
    emit(SetGenderState());
  }

  Future<void> registerUser(String email, String password, String name) async {
    NetworkFunctions.register(name, selectedGender == 0 ? "Male" : "Female", email, password);
  }

}

class RegisterStates {

}

class RegisterInitState extends RegisterStates {

}

class SetGenderState extends RegisterStates {

}