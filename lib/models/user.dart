import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "fname";
  static const EMAIL = "email";
  static const SURNAME = "lname";
  static const LOCATION = "lname";
  static const PROVINCE = "lname";

  String _id;
  String _name;
  String _email;
  String _surname;
  String _location;
  String _province;

//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get surname => _surname;
  String get location => _location;
  String get province => _province;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
    _id = snapshot.data()[ID];
    _surname = snapshot.data()[SURNAME];
    _location = snapshot.data()[LOCATION];
    _province = snapshot.data()[PROVINCE];
  }
}
