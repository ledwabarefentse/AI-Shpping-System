import 'package:aishop_admin/services/orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const NAME = "name";
  static const DESCRIPTION = "description";
  static const PRICE = "price";

  // static const USER_ID = "userId";
  static const QUANTITY = "stockamt";
  // static const STATUS = "status";
  // static const CREATED_AT = "createdAt";

  final String _id;
  final String _Date;
  final int total;
  String _description;
  String _name;
  int _price;
  final int _quantity;
  // int _total;

//  getters
  String get id => _id;

  String get description => _description;

  String get date => _Date;

  String get price => _price.toString();

  int get quantity => _quantity;

  // int get createdAt => _createdAt;

  // public variable
  // List cart;


    OrderModel.fromSnapshot(DocumentSnapshot snapshot, this._id,this._quantity,this._Date,this.total) {
    //_id = snapshot.data()[ID].toString();
    _description = snapshot.data()[DESCRIPTION];
    _price = snapshot.data()[PRICE];
   // _quantity =  snapshot.data()[QUANTITY];
    _name =  snapshot.data()[NAME].toString();


    // _createdAt = snapshot.data()[CREATED_AT];
    // cart = snapshot.data()[CART];
  }

}
