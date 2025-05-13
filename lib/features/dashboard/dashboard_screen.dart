// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freshkart_admin/bloc/dashboard/bloc.dart';
// import 'package:freshkart_admin/bloc/dashboard/event.dart';
// import 'package:freshkart_admin/bloc/dashboard/state.dart';
// import 'package:freshkart_admin/features/dashboard/users_screen.dart';
// import 'package:freshkart_admin/utils/colors.dart';
// import 'package:freshkart_admin/utils/icons.dart';
// import 'package:freshkart_admin/utils/names.dart';
// import 'package:freshkart_admin/widgets/appbar.dart';
// import 'package:freshkart_admin/widgets/revenue_summary.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     context.read<DashboardBloc>().add(DashBoardGetDataEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(title: '#Dashboard'),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Welcome back, Admin 👋',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 'Here’s your latest Freshkart summary',
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 40),

//               GridView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: 4,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(
//                           color: AppColors.containerMultipleColors.values
//                               .elementAt(index),
//                         ),
//                         color: AppColors.containerMultipleColors.keys.elementAt(
//                           index,
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 AppNames.dahboardNames[index],
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Icon(
//                                 AppIcons.dashboardIcons[index],
//                                 color: AppColors.containerMultipleColors.values
//                                     .elementAt(index),
//                               ),
//                             ],
//                           ),
//                           BlocBuilder<DashboardBloc, DashboardState>(
//                             builder: (context, state) {
//                               if (state is DashboardOrderCountLoaded) {
//                                 return Text(
//                                   '${state.orderCount[index]}',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 );
//                               } else {
//                                 return Text(
//                                   '0',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 );
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     onTap: () {
//                       if (index == 2) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (c) => UsersScreen()),
//                         );
//                       }
//                     },
//                   );
//                 },
//               ),

//               const SizedBox(height: 30),
//               RevenueSummarySection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/dashboard/bloc.dart';
import 'package:freshkart_admin/bloc/dashboard/event.dart';
import 'package:freshkart_admin/bloc/dashboard/state.dart';
import 'package:freshkart_admin/features/dashboard/users_screen.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/utils/icons.dart';
import 'package:freshkart_admin/utils/names.dart';
import 'package:freshkart_admin/widgets/appbar.dart';
import 'package:freshkart_admin/widgets/revenue_summary.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(DashBoardGetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: '#Dashboard'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, Admin 👋',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                Text(
                  'Here’s your latest Freshkart summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 30),

                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 2;
                    if (constraints.maxWidth > 900) {
                      crossAxisCount = 4;
                    } else if (constraints.maxWidth > 600) {
                      crossAxisCount = 3;
                    }

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.3,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (index == 2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => UsersScreen(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: AppColors.containerMultipleColors.values
                                    .elementAt(index),
                              ),
                              color: AppColors.containerMultipleColors.keys
                                  .elementAt(index),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppNames.dahboardNames[index],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      AppIcons.dashboardIcons[index],
                                      color: AppColors
                                          .containerMultipleColors
                                          .values
                                          .elementAt(index),
                                    ),
                                  ],
                                ),
                                BlocBuilder<DashboardBloc, DashboardState>(
                                  builder: (context, state) {
                                    if (state is DashboardOrderCountLoaded) {
                                      return Text(
                                        '${state.orderCount[index]}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        '0',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 30),
                const RevenueSummarySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
