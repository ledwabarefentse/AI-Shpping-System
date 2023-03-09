import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const DESCRIPTION = "description";
  static const PRICE = "price";
  static const QUANTITY = "stockamt";
  static const CATEGORY = "category";

  String _id;
  String _description;
  String _name;
  int _price;
  int _quantity;
  String _category;

//  getters
  String get id => _id;

  String get description => _description;

  String get name => _name;

  String get price => _price.toString();

  int get quantity => _quantity;

  String get category => _category;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID].toString();
    _description = snapshot.data()[DESCRIPTION];
    _price = snapshot.data()[PRICE];
    _quantity = snapshot.data()[QUANTITY];
    _name = snapshot.data()[NAME].toString();
    _category = snapshot.data()[CATEGORY];
  }
}
