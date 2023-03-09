import 'package:aishop_admin/models/brands.dart';
import 'package:aishop_admin/utils/costants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BrandsServices {
  String collection = "brands";

  Future<List<BrandModel>> getAll() async =>
      firebaseFiretore.collection(collection).get().then((result) {
        List<BrandModel> brands = [];
        for (DocumentSnapshot brand in result.docs) {
          brands.add(BrandModel.fromSnapshot(brand));
        }
        return brands;
      });
}
