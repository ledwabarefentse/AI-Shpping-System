import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SingleCartProduct extends StatefulWidget {
  final prodname;
  final prodpicture;
  final prodprice;
  final prodtotal;
  final prodquantity;
  final proddescription;
  final cartid;
  final prodindex;
  final stockamt;
  final category;

  SingleCartProduct(
      {this.prodname,
        this.prodpicture,
        this.prodprice,
        this.prodtotal,
        this.prodquantity,
        this.proddescription,
        this.prodindex,
        this.stockamt,
        this.cartid,
        this.category});

  @override
  _SingleCartProductState createState() => _SingleCartProductState();
}

class _SingleCartProductState extends State<SingleCartProduct> {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 30,
      color: Colors.white,
      child: ListTile(
        leading: new Image.network(
          widget.prodpicture,
          width: 70.0,
          height: 70.0,
        ),
        title: new Text(widget.prodname.toString(),
            style: TextStyle(color: Colors.black87)),
        subtitle: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                Expanded(
                  child: new Text(
                    widget.proddescription,
                    style: TextStyle(color: Colors.grey),
                    maxLines: 1,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            new Row(
              children: [

                SizedBox(
                  height: 5,
                  width: 10,
                ),
                Text(
                  " Qty : ${widget.prodquantity.toString()} ",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                  width: 10,
                ),

              ],
            ),
            SizedBox(
              height: 5,
            ),
            new Container(
              alignment: Alignment.bottomRight,
              child: new Text(

                  "R ${widget.prodtotal}"
                      ,
                  style: TextStyle(color: Colors.black)),
            ),
            SizedBox(
              height: 10,
            ),
            new Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 0,
                            width: 0,
                          ),

                        ],
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
