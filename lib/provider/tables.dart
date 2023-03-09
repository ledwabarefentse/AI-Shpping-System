import 'package:aishop_admin/models/orders.dart';
import 'package:aishop_admin/models/products_model.dart';
import 'package:aishop_admin/services/orders.dart';
import 'package:aishop_admin/services/product_service.dart';
import 'package:aishop_admin/utils/costants.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TablesProvider with ChangeNotifier {
  // ANCHOR table headers
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

  List<DatatableHeader> ordersTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,

        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Quantity",
        value: "quantity",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.center),

    DatatableHeader(
        text: "Date",
        value: "date",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
  ];

  List<DatatableHeader> productsTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: false,
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
        text: "Category",
        value: "category",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Quantity",
        value: "quantity",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Price",
        value: "price",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> brandsTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Brand",
        value: "brand",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> categoriesTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Category",
        value: "category",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
  ];
  List<int> perPages = [5, 10, 15, 100];
  int total = 0;
  void getrevenue() async{
    int revenue=0;
    QuerySnapshot ans = await firebaseFiretore.collection('Torders').get();
    for (DocumentSnapshot order in ans.docs) {
      QuerySnapshot ref = await firebaseFiretore.collection('Torders')
          .doc(order.id)
          .collection('Products')
          .get();
      int size = ref.size;
      for (DocumentSnapshot prod in ref.docs) {
        total += prod.data()['total'];
      }
    }

  }

  int revenue=0;
  int currentPerPage;
  int currentPage = 1;
  bool isSearch = false;
  List<Map<String, dynamic>> usersTableSource = List<Map<String, dynamic>>.empty(growable: true);
  List<Map<String, dynamic>> ordersTableSource =
      List<Map<String, dynamic>>.empty(growable: true);
  List<Map<String, dynamic>> productsTableSource = List<Map<String, dynamic>>.empty(growable: true);
  List<Map<String, dynamic>> categoriesTableSource =
      List<Map<String, dynamic>>.empty(growable: true);
  List<Map<String, dynamic>> brandsTableSource = List<Map<String, dynamic>>.empty(growable: true);

  List<Map<String, dynamic>> selecteds = List<Map<String, dynamic>>.empty(growable: true);
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool isLoading = true;
  bool showSelect = true;

  // UserServices _userServices = UserServices();
  // List<UserModel> _users = <UserModel>[];
  // List<UserModel> get users => _users;

  OrderServices _orderServices = OrderServices();
  List<OrderModel> _orders = <OrderModel>[];
  List<OrderModel> get orders => _orders;

  ProductsServices _productsServices = ProductsServices();
  List<ProductModel> _products = <ProductModel>[];
  List<ProductModel> get products => _products;

  // CategoriesServices _categoriesServices = CategoriesServices();
  // List<CategoriesModel> _categories = <CategoriesModel>[];

  // BrandsServices _brandsServices = BrandsServices();
  // List<BrandModel> _brands = <BrandModel>[];

  Future _loadFromFirebase() async {
    // _users = await _userServices.getAllUsers();
    _orders = await _orderServices.getAllOrders();
    _products = await _productsServices.getAllProducts();
    await getrevenue();
    // _brands = await _brandsServices.getAll();
    // _categories = await _categoriesServices.getAll();
  }

  // List<Map<String, dynamic>> _getUsersData() {
  //   isLoading = true;
  //   notifyListeners();
  //   List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
  //   var i = _users.length;
  //   print(i);
  //   for (UserModel userData in _users) {
  //     temps.add({
  //       "id": userData.id,
  //       "email": userData.email,
  //       "name": userData.name,
  //     });
  //     i++;
  //   }
  //   isLoading = false;
  //   notifyListeners();
  //   return temps;
  // }

  // List<Map<String, dynamic>> _getBrandsData() {
  //   List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
  //   for (BrandModel brand in _brands) {
  //     temps.add({
  //       "id": brand.id,
  //       "brand": brand.brand,
  //     });
  //   }
  //   return temps;
  // }

  // List<Map<String, dynamic>> _getCategoriesData() {
  //   List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();

  //   for (CategoriesModel category in _categories) {
  //     temps.add({
  //       "id": category.id,
  //       "category": category.category,
  //     });
  //   }
  //   return temps;
  // }


  List<Map<String, dynamic>> _getOrdersData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>.empty(growable: true);
    for (OrderModel order in _orders) {

      temps.add({
        "id": order.id,
        "date": order.date,
        "description": order.description,
        "price": order.price,
        "quantity": order.quantity

        // "createdAt": DateFormat.yMMMd()
        //     .format(DateTime.fromMillisecondsSinceEpoch(order.createdAt)),
        // "total": "\$${order.total}",
      });
      //rev.add(order.price);
    }


    print("Temps size is : ${temps.length} ");
    return temps;
  }


  // List<Map<String, dynamic>> _getProductsData() {
  //   List<Map<String, dynamic>> temps = List<Map<String, dynamic>>.empty(growable: true);
  //   for (ProductModel product in _products) {
  //     temps.add({
  //       "id": product.id,
  //       "name": product.name,
  //       // "brand": product.brand,
  //       "category": product.category,
  //       "quantity": product.quantity,
  //       // "sale": product.sale,
  //       // "featured": product.featured,
  //       // "colors": product.colors,
  //       // "sizes": product.sizes,
  //       "price": "\$${product.price}",
  //     });
  //   }
  //   return temps;
  // }

  _initData() async {
    isLoading = true;
    notifyListeners();
    await _loadFromFirebase();
    // usersTableSource.addAll(_getUsersData());
    ordersTableSource.addAll(_getOrdersData());
    // productsTableSource.addAll(_getProductsData());
    // categoriesTableSource.addAll(_getCategoriesData());
    // brandsTableSource.addAll(_getBrandsData());

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
      selecteds.add(item);
    } else {
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  onSelectAll(bool value) {
    if (value) {
      selecteds = usersTableSource.map((entry) => entry).toList().cast();
    } else {
      selecteds.clear();
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

  TablesProvider.init() {
    _initData();
  }
}
