import 'package:aishop_admin/utils/costants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aishop_admin/widgets/orderitem/order_item.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:aishop_admin/services/orders.dart';
import 'package:uuid/uuid.dart';

class OrderModal extends StatefulWidget {
  final CollectionReference usersRef;
  final double ordersum;
  final String date;
  final String orderid;
  final String userid;
  final String name;
  final String email;
  final String address;
  OrderModal({this.usersRef,this.ordersum,this.date,this.orderid,this.userid,this.address,this.name,this.email});
  @override
  _OrderModalState createState() => _OrderModalState();
}


class _OrderModalState extends State<OrderModal> {


  @override

  Widget build(BuildContext context) {


  CollectionReference usersRef =widget.usersRef;
  var uuid = Uuid();
String orderid=uuid.v1();
  double orderTotal=0;
  return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight:  Radius.circular(30)
          ),
        ),
      primary: false,
     leadingWidth: double.infinity,
actions: <Widget>[
  Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.black87,
      boxShadow: [
        BoxShadow( color: Colors.grey.withOpacity(0.8),
          spreadRadius: 10,
          blurRadius: 5,
          offset: Offset(0, 7),),
      ],
    ),
    child:Expanded(child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[Center(child:Text(
        'Bill To',
        style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w300,
            decoration: TextDecoration.underline
        ),
      )),
        SizedBox(height: 10,),
        Expanded(child:Text(
          'Username : ${widget.name}',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),),
        Expanded(child:Text(
          'Email : ${widget.email}',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),),
        Expanded(child:Text(
          'Bill Address : ${widget.address}',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),) ,],)),)
],
     leading:Row(children:<Widget>[Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
         color: Colors.black87,
         boxShadow: [
           BoxShadow( color: Colors.grey.withOpacity(0.8),
             spreadRadius: 10,
             blurRadius: 5,
             offset: Offset(0, 7),),
         ],
       ),
       child:Expanded(child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[Expanded(child:Text(
      'Order ID : $orderid',
      style: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w300,
    ),
  ),),Expanded(child:Text(
        'User ID : ${widget.userid}',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
      ),),

        Expanded(child:Text(
    'Purchased On : ${widget.date}',
    style: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w300,
    ),
  ),) ,],)),),SizedBox(width: 50,),
      ]),
  toolbarHeight: 180,
  backgroundColor: Colors.white,
  ),
  body: new StreamBuilder<QuerySnapshot>(
  stream: usersRef.snapshots(),
  builder: (context, snapshot) {
  if (!snapshot.hasData) {

  return SizedBox(
    width: 400,
    height: 400,
  child: CircularProgressIndicator(
  backgroundColor: Colors.grey,
  ),
  );
  } else {

  return new ListView.builder(
  itemBuilder: (context, index) {

      orderTotal+=(snapshot.data.docs[index].get('unit price')).toDouble();




  return SingleCartProduct(

  cartid: snapshot.data.docs[index].id,

  prodname: snapshot.data.docs[index].get('name'),
  prodpicture: snapshot.data.docs[index].get('url'),
  prodquantity: snapshot.data.docs[index].get('quantity'),
  proddescription:
  snapshot.data.docs[index].get('description'),
  prodprice:
  snapshot.data.docs[index].get('unit price'),
  prodindex: index,
  prodtotal:
  snapshot.data.docs[index].get('total'),
  );

  },
  itemCount: snapshot.data.docs.length,
  );

  }
  },
  ),

   persistentFooterButtons: <Widget>[ClipPath(
     clipper: OvalLeftBorderClipper(),
     child: Container(
       height: 110,
       width:400,
       color: Colors.black,
       child: Center(child:Text("Order Total : R ${widget.ordersum}",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white,fontSize: 35),),)
     ),
   ),]
  );
  }
}
