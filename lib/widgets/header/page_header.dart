import 'package:aishop_admin/styles/custom_text.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String text;

  const PageHeader({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return      Row(
      children: [
        SizedBox(width: 30,),
        Padding(
          padding: const EdgeInsets.all(14),
          child: CustomText(text: text, size: 40, weight: FontWeight.bold, color: Colors.grey,),
        ),
      ],
    );
  }
}
