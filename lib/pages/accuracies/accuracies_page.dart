import 'package:aishop_admin/widgets/charts/bar_chart_widget.dart';
import 'package:aishop_admin/widgets/header/page_header.dart';
import 'package:flutter/material.dart';

class AccuraciesPage extends StatefulWidget {
  @override
  _AccuraciesPageState createState() => _AccuraciesPageState();
}

class _AccuraciesPageState extends State<AccuraciesPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
          // testChart()
          PageHeader(
            text: 'AI Models',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //         builder: (BuildContext
                    //         context) =>
                    //             AddProduct()));
                  },
                  icon: Icon(Icons.add),
                  label: Text("TRAIN MODELS"))
            ],
          ),
          // testChart(),
          SizedBox(
            height: 10,
          ),
          AccuracyChart()
        ]));
  }
}
