import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_my_app/rate_my_app.dart';

String month_cover(int month) {
  switch (month) {
    case 1:
      return 'Ocak';
      break;
    case 2:
      return 'Şubat';
      break;
    case 3:
      return 'Mart';
      break;
    case 4:
      return 'Nisan';
      break;
    case 5:
      return 'Mayıs';
      break;
    case 6:
      return 'Haziran';
      break;
    case 7:
      return 'Temmuz';
      break;
    case 8:
      return 'Ağustos';
      break;
    case 9:
      return 'Eylül';
      break;
    case 10:
      return 'Ekim';
      break;
    case 11:
      return 'Kasım';
      break;
    case 12:
      return 'Aralık';
      break;
    default:
      break;
  }
}

const IconData heart_empty = IconData(0xe800);
const IconData heart = IconData(0xe801);

TextStyle kGoogleFont = GoogleFonts.sourceSansPro(color: Colors.black);
TextStyle kGoogleFont2 = GoogleFonts.sourceSerifPro(color: Colors.black);

double font_size = 20;

RateMyApp rateMyApp = RateMyApp(
  preferencesPrefix: 'rateMyApp_',
  minDays: 5,
  minLaunches: 10,
  remindDays: 5,
  remindLaunches: 10,
  googlePlayIdentifier: 'mehmetfurkan.smart_note',
);
