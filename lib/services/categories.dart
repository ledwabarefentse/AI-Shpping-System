import 'package:aishop_admin/models/categories.dart';
import 'package:aishop_admin/utils/costants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CategoriesServices {
  String collection = "categories";

  Future<List<CategoriesModel>> getAll() async =>
      firebaseFiretore.collection(collection).get().then((result) {
        List<CategoriesModel> categories = [];
        for (DocumentSnapshot category in result.docs) {
          categories.add(CategoriesModel.fromSnapshot(category));
        }
        return categories;
      });
}
