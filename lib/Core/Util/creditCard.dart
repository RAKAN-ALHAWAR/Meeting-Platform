part of '../core.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this Util }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Help functions to discover and verify bank cards
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class CreditCardUtilsX {

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  /// With the card number with Luhn Algorithm
  /// https://en.wikipedia.org/wiki/Luhn_algorithm
  static String? validateCardNum(String? input) {
    if (input == null || input.isEmpty) {
      return "This field is required".tr;
    }

    input = getCleanedNumber(input);

    if (input.length < 8) {
      return "Card is invalid".tr;
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return "Card is invalid".tr;
  }

  static CreditCardTypeEX getCardTypeFrmNumber(String input) {
    CreditCardTypeEX cardType;
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CreditCardTypeEX.master;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CreditCardTypeEX.visa;
    } else if (input
        .startsWith(RegExp(r'((506([01]))|(507([89]))|(6500))'))) {
      cardType = CreditCardTypeEX.verve;
    } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
      cardType = CreditCardTypeEX.americanExpress;
    } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      cardType = CreditCardTypeEX.discover;
    } else if (input
        .startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = CreditCardTypeEX.dinersClub;
    } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = CreditCardTypeEX.jcb;
    }
    // else if () {
    /// TODO: Algorithm >>> Add regExp to Mada payment card
    //   cardType = CreditCardType.Mada;
    // }
    else if (input.length <= 8) {
      cardType = CreditCardTypeEX.others;
    } else {
      cardType = CreditCardTypeEX.invalid;
    }
    return cardType;
  }
}