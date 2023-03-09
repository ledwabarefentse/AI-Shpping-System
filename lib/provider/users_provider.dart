import 'package:aishop_admin/models/user.dart';
import 'package:aishop_admin/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';

class UsersProvider with ChangeNotifier {
  List<DatatableHeader> usersTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Name",
        value: "name",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Email",
        value: "email",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<int> perPages = [5, 10, 15, 100];
  int total = 100;
  int currentPerPage;
  int currentPage = 1;
  bool isSearch = false;
  List<Map<String, dynamic>> usersTableSource =
      List<Map<String, dynamic>>.empty(growable: true);
  List<Map<String, dynamic>> usersSelecteds =
      List<Map<String, dynamic>>.empty(growable: true);
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool isLoading = true;
  bool showSelect = true;

  UserServices _usersServices = UserServices();
  List<UserModel> _users = <UserModel>[];
  List<UserModel> get products => _users;

  Future _loadFromFirebase() async {
    _users = await _usersServices.getAllUsers();
  }

  List<Map<String, dynamic>> _getUsersData() {
    List<Map<String, dynamic>> temps =
        List<Map<String, dynamic>>.empty(growable: true);
    for (UserModel user in _users) {
      temps.add({
        "uid": user.id,
        "name": user.name,
        "email": user.email,
      });
    }
    return temps;
  }

  _initData() async {
    isLoading = true;
    notifyListeners();
    await _loadFromFirebase();
    usersTableSource.addAll(_getUsersData());
    isLoading = false;
    notifyListeners();
  }

  onSort(dynamic value) {
    sortColumn = value;
    sortAscending = !sortAscending;
    if (sortAscending) {
      usersTableSource
          .sort((a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
    } else {
      usersTableSource
          .sort((a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
    }
    notifyListeners();
  }

  onSelected(bool value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value) {
      usersSelecteds.add(item);
    } else {
      usersSelecteds.removeAt(usersSelecteds.indexOf(item));
    }
    notifyListeners();
  }

  onSelectAll(bool value) {
    if (value) {
      usersSelecteds = usersTableSource.map((entry) => entry).toList().cast();
    } else {
      usersSelecteds.clear();
    }
    notifyListeners();
  }

  onChanged(int value) {
    currentPerPage = value;
    notifyListeners();
  }

  previous() {
    currentPage = currentPage >= 2 ? currentPage - 1 : 1;
    notifyListeners();
  }

  next() {
    currentPage++;
    notifyListeners();
  }

  UsersProvider.init() {
    _initData();
  }
}
