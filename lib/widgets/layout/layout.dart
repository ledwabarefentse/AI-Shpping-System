import 'package:aishop_admin/navigation/locator.dart';
import 'package:aishop_admin/navigation/routing/route_names.dart';
import 'package:aishop_admin/navigation/routing/router.dart';
import 'package:aishop_admin/services/navigation_service.dart';
import 'package:aishop_admin/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';

class LayoutTemplate extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: Row(
        children: [
          SideMenu(),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Navigator(
                    key: locator<NavigationService>().navigatorKey,
                    onGenerateRoute: generateRoute,
                    initialRoute: HomeRoute,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
