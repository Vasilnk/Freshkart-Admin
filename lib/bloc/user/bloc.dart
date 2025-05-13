import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/user/event.dart';
import 'package:freshkart_admin/bloc/user/state.dart';
import 'package:freshkart_admin/services/user_services.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserServices userServices = UserServices();
  UserBloc(this.userServices) : super(UserInitial()) {
    on<UserLoadingEvent>((event, emit) async {
      emit(UserLoading());

      final users = await userServices.getAllUsers();
      emit(UserLoaded(users));
    });
  }
}
