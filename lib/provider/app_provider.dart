import 'package:aishop_admin/models/orders.dart';
import 'package:aishop_admin/services/orders.dart';
import 'package:aishop_admin/utils/enumerators.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  DisplayedPage currentPage;
  OrderServices _orderServices = OrderServices();
  // OrderModel _orderModel;
  double revenue = 0;

  AppProvider.init() {
    _getRevenue();
    changeCurrentPage(DisplayedPage.HOME);
  }

  changeCurrentPage(DisplayedPage newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  void _getRevenue() async {
    await _orderServices.getAllOrders().then((orders) {
      for (OrderModel order in orders) {
        revenue = revenue;
        print("======= TOTAL REVENUE: ${revenue.toString()}");
        print("======= TOTAL REVENUE: ${revenue.toString()}");
        print("======= TOTAL REVENUE: ${revenue.toString()}");
      }
      notifyListeners();
    });
  }
}
