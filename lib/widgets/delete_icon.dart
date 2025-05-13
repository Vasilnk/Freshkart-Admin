import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_event.dart';

class DeleteIcon extends StatelessWidget {
  final String product;
  final String docId;
  const DeleteIcon({super.key, required this.product, required this.docId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.close, color: Colors.red),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text('Are you sure to delete "$product "'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<ProductBloc>().add(DeleteProductEvent(docId));
                    Navigator.pop(context);
                  },
                  child: Text('Yes', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
