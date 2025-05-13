class AdminModel {
  final String id;
  final String password;
  AdminModel(this.id, this.password);

  factory AdminModel.froMap(Map<String, dynamic> map) {
    return AdminModel(map['adminId'], map['password']);
  }
}
