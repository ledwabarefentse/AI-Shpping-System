import 'package:aishop_admin/widgets/size_constraint/size_constraint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('size constraint ...', (tester) async {
    SizeConstraintWidget sizeConstraintWidget = SizeConstraintWidget();
    await tester.pumpWidget(makeTestableWidget(child: sizeConstraintWidget));
    expect(find.byType(Container), findsWidgets);
  });
}
