import 'package:aishop_admin/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('loading ...', (tester) async {
    Loading loading = Loading();
    await tester.pumpWidget(makeTestableWidget(child: loading));
    expect(find.byType(Center), findsWidgets);
  });
}
