import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/admin/admin_bloc.dart';
import 'package:freshkart_admin/bloc/admin/admin_event.dart';
import 'package:freshkart_admin/utils/colors.dart';

class FieldContainer extends StatelessWidget {
  final String title;
  final String value;
  FieldContainer({super.key, required this.title, required this.value});
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                child: Text(
                  'Change',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (c) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text('Change $title'),
                        contentPadding: EdgeInsets.only(
                          top: 30,
                          bottom: 15,
                          left: 20,
                          right: 20,
                        ),
                        content: TextField(
                          controller: textFieldController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              final isAdmin =
                                  title == 'Admin Id' ? true : false;
                              context.read<AdminBloc>().add(
                                UpdateAdminEvent(
                                  textFieldController.text.trim(),
                                  isAdmin,
                                ),
                              );
                              context.read<AdminBloc>().add(FetchEvent());
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(color: AppColors.greenColor),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
