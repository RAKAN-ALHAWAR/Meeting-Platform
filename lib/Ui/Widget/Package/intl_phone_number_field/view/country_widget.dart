import 'package:flutter/material.dart';
import '../../../widget.dart';
import '../models/country_code_model.dart';
import '../models/dialog_config.dart';
import 'flag_view.dart';

class CountryWidget extends StatelessWidget {
  final CountryCodeModel countryCodeModel;
  final DialogConfig dialogConfig;
  final bool isSelected;
  const CountryWidget(
      {required this.countryCodeModel,
      required this.dialogConfig,
      required this.isSelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dialogConfig.countryItemHeight,
      // color: isSelected ? dialogConfig.selectedItemColor : Colors.transparent,
      color: Colors.transparent,
      child: Row(children: [
        FlagView(
            countryCodeModel: countryCodeModel,
            isFlat: dialogConfig.flatFlag,
            size: dialogConfig.itemFlagSize,
        ),
        const SizedBox(width: 25),
        Expanded(
          child: TextX(
            countryCodeModel.name,
            overflow: TextOverflow.ellipsis,
            style: dialogConfig.textStyle,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(width: 10),
        Directionality(
          textDirection: TextDirection.ltr,
          child: TextX(
            countryCodeModel.dial_code,
            style: dialogConfig.textStyle,
          ),
        )
      ],
      ),
    );
  }
}
