import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/common/constants.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Constant kDrawerTheme Test', () {
    test('kDrawerTheme should have correct background color', () {
      expect(kDrawerTheme.backgroundColor, Colors.grey.shade700);
    });
  });

  group('Constant kColorScheme Test', () {
    test('kColorScheme should have correct color values', () {
      expect(kColorScheme.primary, kMikadoYellow);
      expect(kColorScheme.secondary, kPrussianBlue);
      expect(kColorScheme.surface, kRichBlack);
      expect(kColorScheme.brightness, Brightness.dark);
    });
  });
}