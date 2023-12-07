import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());

  int selectedGender = 0;

  void setGender(int value) {
    selectedGender = value;
    emit(SetGenderState());
  }

}

class RegisterStates {

}

class RegisterInitState extends RegisterStates {

}

class SetGenderState extends RegisterStates {

}