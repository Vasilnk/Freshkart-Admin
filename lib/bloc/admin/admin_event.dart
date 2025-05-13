class AdminEvent {}

class LoginEvent extends AdminEvent {}

class FetchEvent extends AdminEvent {}

class UpdateAdminEvent extends AdminEvent {
  final String value;
  final bool idAdmin;
  UpdateAdminEvent(this.value, this.idAdmin);
}
