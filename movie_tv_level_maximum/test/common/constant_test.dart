import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_tv_level_maximum/common/constants.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Constant TextTheme Tests', () {
    test('kHeading5 style should have correct properties', () {
      final expectedStyle = GoogleFonts.poppins(
        fontSize: 23,
        fontWeight: FontWeight.w400,
      );
      expect(kHeading5, expectedStyle);
    });

    test('kHeading6 style should have correct properties', () {
      final expectedStyle = GoogleFonts.poppins(
        fontSize: 19,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      );
      expect(kHeading6, expectedStyle);
    });

    test('kSubtitle style should have correct properties', () {
      final expectedStyle = GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      );
      expect(kSubtitle, expectedStyle);
    });

    test('kBodyText style should have correct properties', () {
      final expectedStyle = GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );
      expect(kBodyText, expectedStyle);
    });

    test('kTextTheme should contain expected styles', () {
      expect(kTextTheme.headlineMedium, kHeading5);
      expect(kTextTheme.headlineSmall, kHeading6);
      expect(kTextTheme.labelMedium, kSubtitle);
      expect(kTextTheme.bodyMedium, kBodyText);
    });
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
