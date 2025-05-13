import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/admin/admin_event.dart';
import 'package:freshkart_admin/bloc/admin/admin_state.dart';
import 'package:freshkart_admin/services/admin_services.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AdminServices adminServices = AdminServices();

  AdminBloc(this.adminServices) : super(AdminStateInitial()) {
    on<FetchEvent>((event, emit) async {
      final admin = await adminServices.fatchAdmin();

      emit(AdminLoaded(id: admin?['adminId'], password: admin?['password']));
    });

    on<UpdateAdminEvent>((event, emit) async {
      await adminServices.updateAdminField(event.value, event.idAdmin);
    });
  }
}
