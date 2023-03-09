import 'package:aishop_admin/models/orders.dart';
import 'package:aishop_admin/utils/costants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class OrderServices {
  String collection = "Torders";
  Future<List<String>>ids;
  List<DocumentSnapshot>ods;
int revenue=0;
 Future<List<OrderModel>> getAllOrders()  async{
   List<OrderModel> orders=[];

   QuerySnapshot ans =await firebaseFiretore.collection('Torders').get();
   for (DocumentSnapshot order in ans.docs){
     QuerySnapshot  ref=await firebaseFiretore.collection('Torders').doc(order.id).collection('Products').get();
     int size =ref.size;
     String date= DateFormat.yMMMd().add_jm().format(order.get('date').toDate()).toString();

    for(DocumentSnapshot prod in ref.docs ){
      revenue+=prod.data()['total'];
    }

     orders.add(OrderModel.fromSnapshot(order, order.id,size , date,revenue));



   }

   return orders;


 }

 Future<String> getusername(String user_id)async{
   String name;
   String fname;
   String lname;
   FirebaseFirestore _firestore = FirebaseFirestore.instance;
   CollectionReference _collectionReference = _firestore.collection("Users");
   DocumentReference _doc = _collectionReference.doc(user_id);
   DocumentReference _documentReference = _doc.collection("info").doc(user_id);

   _documentReference.get().then((documentSnapshot) => {



           fname= documentSnapshot.get("fname").toString(),
           lname = documentSnapshot.get("lname"),
           name="$fname $lname"


   });
   return name;
 }

}



