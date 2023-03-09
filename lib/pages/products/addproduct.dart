import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aishop_admin/provider/products_provider.dart';
import 'package:aishop_admin/widgets/header/page_header.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_table/responsive_table.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  static const lightblack = Color(0xFF181818);
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);

  String Name,Category,Description,Price;

  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(color:lightblack),
        body: Column(
            children: [
              PageHeader(
                text: 'Add New Product',
              ),
              InkWell(
              child: (imageUrl != null)
                  ? Image.network(imageUrl)
                  : CircleAvatar(
                radius: 65,
                backgroundImage: imageUrl != null
                    ? NetworkImage(imageUrl)
                    : null,
              ),
                onTap:(){
                  uploadImage();
                }
              ),
              SizedBox(height: 20.0,),
              Container(
                margin: EdgeInsets.only(
                    left: 0.0, top: 0.0, bottom: 0.0, right: 400.0),
                child: Text("Name",
                    style: new TextStyle(
                        color: lightblack,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0)),
              ),
              Container(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //====================================================================================row
                      children: [
                        Container(
                            width: 450,
                            height: 50,
                            child: TextFormField(
                              onChanged: (thename) {
                                Name = thename;
                              },
                              decoration: InputDecoration(
                                fillColor: black,
                                hintText: ' ',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: lightblack, width: 2.0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: lightblack, width: 2.0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              style: TextStyle(
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w300),
                            )),
                        //====================================================================================row
                      ]
                    //====================================================================================rowEnded
                  )),

              Container(
                margin: EdgeInsets.only(
                    left: 0.0, top: 0.0, bottom: 0.0, right: 375.0),
                child: Text("Category",
                    style: new TextStyle(
                        color: lightblack,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0)),
              ),
              Container(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //====================================================================================row
                      children: [
                        Container(
                            width: 450,
                            height: 50,
                            child: TextFormField(
                              onChanged: (thecategory) {
                                Category = thecategory;
                              },
                              decoration: InputDecoration(
                                fillColor: black,
                                hintText: ' ',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: lightblack, width: 2.0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: lightblack, width: 2.0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              style: TextStyle(
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w300),
                            )),
                        //====================================================================================row
                      ]
                    //====================================================================================rowEnded
                  )),

              Container(
                margin: EdgeInsets.only(
                    left: 0.0, top: 0.0, bottom: 0.0, right: 400.0),
                child: Text("Price",
                    style: new TextStyle(
                        color: lightblack,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0)),
              ),
              Container(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //====================================================================================row
                      children: [
                        Container(
                            width: 450,
                            height: 50,
                            child: TextFormField(
                              onChanged: (theprice) {
                                Price = theprice;
                              },
                              decoration: InputDecoration(
                                fillColor: black,
                                hintText: ' ',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: lightblack, width: 2.0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: lightblack, width: 2.0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              style: TextStyle(
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w300),
                            )),
                        //====================================================================================row
                      ]
                    //====================================================================================rowEnded
                  )),

              Container(
                margin: EdgeInsets.only(
                    left: 0.0, top: 0.0, bottom: 0.0, right: 350.0),
                child: Text("Description",
                    style: new TextStyle(
                        color: lightblack,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0)),
              ),
              Container(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //====================================================================================row
                      children: [
                        Container(
                            width: 450,
                            height: 50,
                            child: TextFormField(
                              onChanged: (thedescription) {
                                Description = thedescription;
                              },
                              decoration: InputDecoration(
                                fillColor: black,
                                hintText: ' ',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: lightblack, width: 2.0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: lightblack, width: 2.0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              style: TextStyle(
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w300),
                            )),
                        //====================================================================================row
                      ]
                    //====================================================================================rowEnded
                  )),

              SizedBox(
                height: 15,
              ),
              RaisedButton(
                child: Text('Add New Product'),
                color: white,
                onPressed: () { addit(Name,Category,Description,Price);
                  Navigator.of(context).pop(); }            )
            ]),
    );
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('folderName/imageName')
            .putFile(file);
            // .onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }
  }

  addit(String name,String category,String description,String price) async {

    DateTime now = new DateTime.now();
    DateTime date =
    new DateTime(now.year, now.month, now.day, now.hour, now.minute);

    DocumentReference docRef = FirebaseFirestore.instance as DocumentReference;
        docRef
        .collection('Products')
        .add({
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'stockamt': 100,
      'clicks': 0,
      'Purchased by': 0,
      'date': date
    });
  }

}
