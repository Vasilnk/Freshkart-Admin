import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freshkart_admin/bloc/user/bloc.dart';
import 'package:freshkart_admin/features/auth/login_screen.dart';
import 'package:freshkart_admin/bloc/admin/admin_bloc.dart';
import 'package:freshkart_admin/bloc/category/category_bloc.dart';
import 'package:freshkart_admin/bloc/coverImage/image_bloc.dart';
import 'package:freshkart_admin/bloc/dashboard/bloc.dart';
import 'package:freshkart_admin/bloc/order/bloc.dart';
import 'package:freshkart_admin/bloc/product/product_bloc.dart';
import 'package:freshkart_admin/features/update/category/add_category_screen.dart';
import 'package:freshkart_admin/features/update/category/category_screen.dart';
import 'package:freshkart_admin/features/landing_screen.dart';
import 'package:freshkart_admin/features/update/cover_images.dart';
import 'package:freshkart_admin/features/update/notification.dart';
import 'package:freshkart_admin/features/update/product/offer_product_screen.dart';
import 'package:freshkart_admin/services/admin_services.dart';
import 'package:freshkart_admin/services/category_services.dart';
import 'package:freshkart_admin/services/cover_%20image_services.dart';
import 'package:freshkart_admin/services/dashboard_services.dart';
import 'package:freshkart_admin/services/order_services.dart';
import 'package:freshkart_admin/services/product_services.dart';
import 'package:freshkart_admin/features/auth/splash_screen.dart';
import 'package:freshkart_admin/services/user_services.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(path: Routes.landing, builder: (context, state) => LandingScreen()),
    GoRoute(path: Routes.login, builder: (context, state) => LoginScreen()),
    GoRoute(path: Routes.offer, builder: (context, state) => OfferScreen()),
    GoRoute(
      path: Routes.coverImages,
      builder: (context, state) => CoverImagesScreen(),
    ),
    GoRoute(
      path: Routes.notification,
      builder: (context, state) => SendCommonNotificationScreen(),
    ),
    GoRoute(
      path: Routes.category,
      builder: (context, state) => CategoryScreen(),
    ),
    GoRoute(
      path: Routes.addCategory,
      builder: (context, state) => AddCategoryPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(FirestoreCategoryService()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(FirestoreProductServices()),
        ),
        BlocProvider<CoverImageBloc>(
          create: (context) => CoverImageBloc(CoverImageServices()),
        ),
        BlocProvider<AdminBloc>(
          create: (context) => AdminBloc(AdminServices()),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(DashboardServices()),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(OrderServices()),
        ),
        BlocProvider(create: (context) => UserBloc(UserServices())),
      ],

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.light(
            primary: Colors.black,
            onPrimary: Colors.white,
            surface: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Routes {
  static const String landing = '/landing';
  static const String addCategory = '/addCategory';
  static const String login = '/login';
  static const String category = '/category';
  static const String forgot = '/forgot';
  static const String coverImages = '/coverImages';
  static const String notification = '/notification';
  static const String offer = '/offer';
}
