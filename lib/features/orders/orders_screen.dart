import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/order/bloc.dart';
import 'package:freshkart_admin/bloc/order/event.dart';
import 'package:freshkart_admin/features/orders/orders_by_category.dart';
import 'package:freshkart_admin/utils/constants.dart';
import 'package:freshkart_admin/widgets/appbar.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String selectedStatus = 'All';
  late PageController pageController;
  late ScrollController chipScrollController;

  @override
  void initState() {
    context.read<OrderBloc>().add(LoadOrderEvent());
    pageController = PageController(initialPage: 0);
    chipScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    chipScrollController.dispose();
    super.dispose();
  }

  void scrollToChip(int index) {
    final offset = (index * 100.0) - 20;
    chipScrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void onChipSelected(int index) {
    setState(() {
      selectedStatus = Constants.statusList[index];
    });
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    scrollToChip(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Orders'),
      body: Column(
        children: [
          SingleChildScrollView(
            controller: chipScrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(Constants.statusList.length, (index) {
                final status = Constants.statusList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    selectedColor: Colors.black,
                    checkmarkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white,
                    label: Text(
                      status,
                      style: TextStyle(
                        color:
                            selectedStatus == status
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    selected: selectedStatus == status,
                    onSelected: (_) => onChipSelected(index),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: Constants.statusList.length,
              onPageChanged: (index) {
                setState(() {
                  selectedStatus = Constants.statusList[index];
                });
                scrollToChip(index - 1);
              },
              itemBuilder: (context, index) {
                final status = Constants.statusList[index];
                return OrdersByCategory(status: status);
              },
            ),
          ),
        ],
      ),
    );
  }
}
