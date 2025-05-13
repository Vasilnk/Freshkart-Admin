class AdminState {}

class AdminLoaded extends AdminState {
  final String id;
  final String password;
  AdminLoaded({required this.id, required this.password});
}

class AdminStateInitial extends AdminState {}
