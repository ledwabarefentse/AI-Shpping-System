import 'package:aishop_admin/main.dart';
import 'package:aishop_admin/navigation/routing/route_names.dart';
import 'package:aishop_admin/pages/accuracies/accuracies_page.dart';
import 'package:aishop_admin/pages/home/home_page.dart';
import 'package:aishop_admin/pages/login/login.dart';
import 'package:aishop_admin/pages/orders/orders_page.dart';
import 'package:aishop_admin/pages/products/products_page.dart';
import 'package:aishop_admin/pages/recommended_products/recommended_products.dart';
import 'package:aishop_admin/pages/registration/registration.dart';
import 'package:aishop_admin/pages/users/users_page.dart';
import 'package:aishop_admin/widgets/layout/layout.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print('generateRoute: ${settings.name}');
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(HomePage());
    case UsersRoute:
      return _getPageRoute(UsersPage());
    case ProductsRoute:
      return _getPageRoute(ProductsPage());
    case OrdersRoute:
      return _getPageRoute(OrdersPage());
    case LoginRoute:
      return _getPageRoute(LoginPage());
    case RegistrationRoute:
      return _getPageRoute(RegistrationPage());
          case LayoutRoute:
      return _getPageRoute(LayoutTemplate());
                case AccuraciesRoute:
      return _getPageRoute(AccuraciesPage());
                case RecommendedProductsRoute:
      return _getPageRoute(RecommendedProductsPage());
                case PageControllerRoute:
      return _getPageRoute(AppPagesController());
    default:
      return _getPageRoute(LoginPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}