
import 'package:aishop_admin/models/products_model.dart';
import 'package:aishop_admin/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';

class ProductsProvider with ChangeNotifier {

  List<DatatableHeader> productsTableHeader = [
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
        text: "Category",
        value: "category",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Description",
        value: "description",
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

  List<int> perPages = [5, 10, 15, 100];
  int total = 100;
  int currentPerPage;
  int currentPage = 1;
  bool isSearch = false;
  List<Map<String, dynamic>> productsTableSource = List<Map<String, dynamic>>.empty(growable: true);
  List<Map<String, dynamic>> productsSelecteds = List<Map<String, dynamic>>.empty(growable: true);
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool isLoading = true;
  bool showSelect = true;

  ProductsServices _productsServices = ProductsServices();
  List<ProductModel> _products = <ProductModel>[];
  List<ProductModel> get products => _products;

  Future _loadFromFirebase() async {
    _products = await _productsServices.getAllProducts();

  }

  List<Map<String, dynamic>> _getProductsData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>.empty(growable: true);
    for (ProductModel product in _products) {
      temps.add({
        "id": product.id,
        "name": product.name,
        "category": product.category,
        "description": product.description,
        "price": product.price,
        "quantity": product.quantity

      });
    }
    return temps;
  }
  _initData() async {
    isLoading = true;
    notifyListeners();
    await _loadFromFirebase();
    productsTableSource.addAll(_getProductsData());
    isLoading = false;
    notifyListeners();
  }

  onSort(dynamic value) {
    sortColumn = value;
    sortAscending = !sortAscending;
    if (sortAscending) {
      productsTableSource
          .sort((a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
    } else {
      productsTableSource
          .sort((a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
    }
    notifyListeners();
  }

  onSelected(bool value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value) {
      productsSelecteds.add(item);
    } else {
      productsSelecteds.removeAt(productsSelecteds.indexOf(item));
    }
    notifyListeners();
  }

  onSelectAll(bool value) {
    if (value) {
      productsSelecteds = productsTableSource.map((entry) => entry).toList().cast();
    } else {
      productsSelecteds.clear();
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

  ProductsProvider.init() {
    _initData();
  }
}
