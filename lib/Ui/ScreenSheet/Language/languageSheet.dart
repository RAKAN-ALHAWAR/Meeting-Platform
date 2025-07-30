import 'package:flutter/material.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../Config/Translation/translation.dart';
import '../../../../Data/data.dart';
import '../../../UI/Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Choose one of the languages available for the application
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

languageSheetX(Function(String val) changeLanguage) {
  return bottomSheetX(
    title: 'Application language',
    child: Column(
      /// Fetch available languages
      children: TranslationX.languages.map(
        (Map<String, String> language) {
          return RadioButtonX(groupValue: TranslationX.getLanguageCode, value: language[NameX.code],label: language[NameX.name], onChanged: (_) async {
            await changeLanguage(language[NameX.code]!);
          }).fadeAnimation200;
        },
      ).toList(),
    ),
  );
}
