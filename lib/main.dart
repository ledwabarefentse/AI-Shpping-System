import 'package:aishop_admin/navigation/locator.dart';
import 'package:aishop_admin/navigation/routing/route_names.dart';
import 'package:aishop_admin/navigation/routing/router.dart';
import 'package:aishop_admin/pages/login/login.dart';
import 'package:aishop_admin/provider/app_provider.dart';
import 'package:aishop_admin/provider/auth.dart';
import 'package:aishop_admin/provider/products_provider.dart';
import 'package:aishop_admin/provider/tables.dart';
import 'package:aishop_admin/utils/costants.dart';
import 'package:aishop_admin/widgets/layout/layout.dart';
import 'package:aishop_admin/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider.init()),
    ChangeNotifierProvider.value(value: AuthProvider.initialize()),
    ChangeNotifierProvider.value(value: TablesProvider.init()),
    ChangeNotifierProvider.value(value: ProductsProvider.init()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Shop Admin',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: PageControllerRoute,
    );
  }
}

class AppPagesController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return FutureBuilder(
      // Initialize FlutterFire:
      future: initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Something went wrong")],
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print(authProvider.status.toString());
          switch (authProvider.status) {
            case Status.Uninitialized:
              return Loading();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginPage();
            case Status.Authenticated:
              return LayoutTemplate();
            default:
              return LoginPage();
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
        );
      },
    );
  }
}
