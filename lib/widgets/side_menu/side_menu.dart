import 'package:aishop_admin/navigation/locator.dart';
import 'package:aishop_admin/navigation/routing/route_names.dart';
import 'package:aishop_admin/provider/app_provider.dart';
import 'package:aishop_admin/services/navigation_service.dart';
import 'package:aishop_admin/utils/enumerators.dart';
import 'package:aishop_admin/widgets/side_menu/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      decoration: BoxDecoration(color: Colors.black,
          // gradient: LinearGradient(
          //   colors: [Colors.indigo, Colors.indigo.shade600],
          // ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200], offset: Offset(3, 5), blurRadius: 17)
          ]),
      width: 250,
      child: Container(
        child: Column(
          children: [
            SideMenuItem(
              icon: Icons.dashboard,
              text: 'Dashboard',
              active: appProvider.currentPage == DisplayedPage.HOME,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.HOME);
                locator<NavigationService>().navigateTo(HomeRoute);
              },
            ),
            SideMenuItem(
              icon: Icons.people,
              text: 'Users',
              active: appProvider.currentPage == DisplayedPage.USERS,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.USERS);

                locator<NavigationService>().navigateTo(UsersRoute);
              },
            ),
            SideMenuItem(
              icon: Icons.shopping_cart,
              text: 'Orders',
              active: appProvider.currentPage == DisplayedPage.ORDERS,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.ORDERS);
                locator<NavigationService>().navigateTo(OrdersRoute);
              },
            ),
            SideMenuItem(
              icon: Icons.shopping_basket_outlined,
              text: 'Products',
              active: appProvider.currentPage == DisplayedPage.PRODUCTS,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.PRODUCTS);
                locator<NavigationService>().navigateTo(ProductsRoute);
              },
            ),
            SideMenuItem(
              icon: Icons.category,
              text: 'Recommended Products',
              active: appProvider.currentPage == DisplayedPage.BRANDS,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.BRANDS);
                locator<NavigationService>().navigateTo(RecommendedProductsRoute);
              },
            ),
            SideMenuItem(
              icon: Icons.category,
              text: 'AI Models',
              active: appProvider.currentPage == DisplayedPage.CATEGORIES,
              onTap: () {
                appProvider.changeCurrentPage(DisplayedPage.CATEGORIES);
                locator<NavigationService>().navigateTo(AccuraciesRoute);
              },
            ),

            // SideMenuItemDesktop(
            //   icon: Icons.shopping_basket_outlined,
            //   text: 'Past Purchases',
            //   active: appProvider.currentPage == DisplayedPage.PRODUCTS,
            //   onTap: () {
            //     appProvider.changeCurrentPage(DisplayedPage.PRODUCTS);
            //     locator<NavigationService>().navigateTo(ProductsRoute);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
