import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:box_tab_indicator/box_tab_indicator.dart';

void main() {
  test('Create box painter', () {
    final indicator = BoxTabIndicator();
    expect(indicator.createBoxPainter() is BoxPainter, isTrue);
  });
}
