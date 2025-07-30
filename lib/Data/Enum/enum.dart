part of '../data.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// All enums that are used throughout the project
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


//============================================================================
// Basic

enum DeviceTypeEX { mobile, tablet, desktop, web }

enum PlatformTypeEX { android, ios, web, mac, windows, linux, fuchsia }

enum SizeTypeEX { small, medium, large }

enum ButtonStateEX { normal, loading, success, failed }

//============================================================================
// Custom

enum ProductSortEX {
  all('All'),
  seller("Best seller"),
  rated("Highest rated"),
  priceHigh("Price from high to low"),
  priceLow("Price from lowest to highest");

  final String name;
  const ProductSortEX(this.name);
}
enum GeneralSortEX {
  all('All'),
  latestAddition("latest_created"),
  oldestAddition("oldest_created"),
  remainingAmountHigh("remaining_price_asc"),
  remainingAmountLow("remaining_price_desc");

  final String name;
  const GeneralSortEX(this.name);
}

enum RecurringSortEX {
  all('All'),
  daily("Daily"),
  weekly("Weekly"),
  monthly("Monthly");

  final String name;
  const RecurringSortEX(this.name);
}

enum CreditCardTypeEX {
  master,
  visa,
  verve,
  discover,
  americanExpress,
  dinersClub,
  jcb,
  mada,
  others,
  invalid
}
