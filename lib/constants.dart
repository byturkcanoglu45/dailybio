import 'package:flutter/cupertino.dart';

String month_cover(int month) {
  print(month);
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
