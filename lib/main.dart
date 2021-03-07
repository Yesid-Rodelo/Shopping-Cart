import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/order/order_bloc.dart';
import 'package:shopping_cart/routes/routes.dart';
import 'package:shopping_cart/bloc/cart/cart_bloc.dart';
import 'package:shopping_cart/bloc/products/products_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => new ProductsBloc(firestore: firestore)),
        BlocProvider(create: (_) => new CartBloc(firestore: firestore)),
        BlocProvider(create: (_) => new OrderBloc(firestore: firestore)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping Cart',
        initialRoute: 'home',
        routes: getRoutes(),
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
      ),
    );
  }
}
