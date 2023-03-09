import 'package:aishop_admin/models/products_model.dart';
import 'package:aishop_admin/utils/costants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsServices {
  String collection = "Products";

  Future<List<ProductModel>> getAllProducts() async =>
      firebaseFiretore.collection(collection).get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });
}
