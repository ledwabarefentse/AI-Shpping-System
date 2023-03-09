import 'dart:io';

import 'package:aishop_admin/widgets/header/page_header.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class PastPurchasePage extends StatefulWidget {
  @override
  _PastPurchasePage createState() => _PastPurchasePage();
}

class _PastPurchasePage extends State<PastPurchasePage> {
  List<List<dynamic>> data = [];
  loadAsset() async {
    final myData =
        await rootBundle.loadString("assets/csv data/past_purchases.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    print(csvTable);
    data = csvTable;
    setState(() {});
  }

  ScrollController _controller = ScrollController();

  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller
          .animateTo(_controller.position.maxScrollExtent,
              duration: Duration(seconds: 1), curve: Curves.ease)
          .then((value) async {
        await Future.delayed(Duration(seconds: 2));
        _controller.animateTo(_controller.position.minScrollExtent,
            duration: Duration(seconds: 1), curve: Curves.ease);
      });
    });
  }

  callMeWidget() {
    return Container(
      height: 100,
      width: 100,
      color: Colors.red,
      margin: EdgeInsets.all(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () async {
            await loadAsset();

            //print(data);
          }),
      body: Container(
          child: SingleChildScrollView(
              controller: _controller,
              scrollDirection: Axis.vertical,
              child: Column(children: <Widget>[
                SizedBox(
                  height: 0,
                  width: 10,
                ),
                PageHeader(
                  text: 'Past Purchase',
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.all(130.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Table(
                              columnWidths: {
                                0: FixedColumnWidth(800.0),
                                1: FixedColumnWidth(800.0),
                              },
                              border: TableBorder.all(width: 2.5),
                              children: data.map((item) {
                                return TableRow(
                                    children: item.map((row) {
                                  return Container(
                                    color: row.toString().contains("NA")
                                        ? Colors.white
                                        : Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        row.toString(),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                }).toList());
                              }).toList(),
                            ),
                          )
                        ]))
              ]))),
    );
  }
}
