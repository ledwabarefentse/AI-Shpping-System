import 'package:aishop_admin/provider/tables.dart';
import 'package:aishop_admin/services/orders.dart';
import 'package:aishop_admin/utils/costants.dart';
import 'package:aishop_admin/widgets/header/page_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:aishop_admin/widgets/order_modal/order_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    final TablesProvider tablesProvider = Provider.of<TablesProvider>(context);
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
          PageHeader(
            text: 'Orders',
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(0),
            constraints: BoxConstraints(
              maxHeight: 700,
            ),
            child: Card(
              elevation: 1,
              shadowColor: Colors.black,
              clipBehavior: Clip.none,
              child: ResponsiveDatatable(
                title: null,
                actions: [
                  if (tablesProvider.isSearch)
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                setState(() {
                                  tablesProvider.isSearch = false;
                                });
                              }),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search), onPressed: () {})),
                    )),
                  if (!tablesProvider.isSearch)
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            tablesProvider.isSearch = true;
                          });
                        })
                ],
                headers: tablesProvider.ordersTableHeader,
                source: tablesProvider.ordersTableSource,
                selecteds: tablesProvider.selecteds,
                showSelect: tablesProvider.showSelect,
                autoHeight: false,
                onTabRow: (data) async {
                  double sum = 0.0;
                  String userid;
                  String name;
                  String address;
                  String email;
                  CollectionReference usersRef = await FirebaseFirestore
                      .instance
                      .collection('Torders')
                      .doc(data["id"])
                      .collection("Products");
                  //update order total
                  await FirebaseFirestore.instance
                      .collection("Torders")
                      .doc(data["id"])
                      .collection("Products")
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((result) {
                      sum += result.data()['total'];
                      // print("sum :" + sum.toString());
                      userid = result.data()['uid'];
                    });
                  });

                  DocumentSnapshot ref = await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(data["id"])
                      .collection('info')
                      .doc(data["id"])
                      .get();

                  name = '${ref.data()['fname']} ${ref.data()['lname']}';
                  address =
                      '${ref.data()['location']},${ref.data()['province']}';
                  email = ref.data()['email'];
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OrderModal(
                          usersRef: usersRef,
                          ordersum: sum,
                          date: data["date"],
                          orderid: data["id"],
                          userid: userid,
                          name: name,
                          address: address,
                          email: email)));
                },
                onSort: tablesProvider.onSort,
                sortAscending: tablesProvider.sortAscending,
                sortColumn: tablesProvider.sortColumn,
                isLoading: tablesProvider.isLoading,
                onSelect: tablesProvider.onSelected,
                onSelectAll: tablesProvider.onSelectAll,
                footers: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text("Rows per page:"),
                  ),
                  if (tablesProvider.perPages != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: DropdownButton(
                          value: tablesProvider.currentPerPage,
                          items: tablesProvider.perPages
                              .map((e) => DropdownMenuItem(
                                    child: Text("$e"),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {}),
                    ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                        "${tablesProvider.currentPage} - ${tablesProvider.currentPage} of ${tablesProvider.total}"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    ),
                    onPressed: tablesProvider.previous,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: tablesProvider.next,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
