// ignore_for_file: non_constant_identifier_names

library;

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';

import '../../../../Config/config.dart';
import '../../../../UI/Widget/widget.dart';
import 'models/country_code_model.dart';
import 'models/country_config.dart';
import 'models/dialog_config.dart';
import 'models/phone_config.dart';
import 'util/general_util.dart';
import 'view/country_code_bottom_sheet.dart';
import 'view/flag_view.dart';

export 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

export 'models/country_code_model.dart';
export 'models/country_config.dart';
export 'models/dialog_config.dart';
export 'models/phone_config.dart';

class InternationalPhoneNumberInput extends StatefulWidget {
  final TextEditingController controller;
  final double? height;
  final bool inactive;
  final DialogConfig dialogConfig;
  final CountryConfig countryConfig;
  final PhoneConfig phoneConfig;
  final int initCountry;
  final bool isActiveError;
  final dynamic Function(IntPhoneNumber number)? onInputChanged;
  final double betweenPadding;
  final MaskedInputFormatter? formatter;
  final List<TextInputFormatter> inputFormatters;
  final Future<String?> Function()? loadFromJson;
  final String? Function(String?)? validate;
  final bool isShowCountryCode;
  final bool isDisableChangeCountryCode;
  InternationalPhoneNumberInput(
      {super.key,
      TextEditingController? controller,
      this.height = 50,
      this.inputFormatters = const [],
      int? initCountry,
      this.betweenPadding = 23,
      this.onInputChanged,
      this.loadFromJson,
      this.formatter,
      this.validate,
      this.inactive = false,
      this.isActiveError = false,
      this.isShowCountryCode = true,
      this.isDisableChangeCountryCode = false,
      DialogConfig? dialogConfig,
      CountryConfig? countryConfig,
      PhoneConfig? phoneConfig,
      })
      : dialogConfig = dialogConfig ?? DialogConfig(),
        controller = controller ?? TextEditingController(),
        countryConfig = countryConfig ?? CountryConfig(),
        initCountry = initCountry ?? 966,
        phoneConfig = phoneConfig ?? PhoneConfig();

  @override
  State<InternationalPhoneNumberInput> createState() =>
      _InternationalPhoneNumberInputState();
}

class _InternationalPhoneNumberInputState
    extends State<InternationalPhoneNumberInput> {
  List<CountryCodeModel>? countries;
  CountryCodeModel selected =
      CountryCodeModel(name: "", dial_code: "+963", code: "sa");

  late FocusNode node;

  @override
  void initState() {
    if (widget.loadFromJson == null) {
      getAllCountry().then((value) => selected = countries!.firstWhere(
            (x) => x.dial_code == "+${widget.initCountry}",
            orElse: () => countries!.firstWhere((x) => x.dial_code == "+966"),
          ));
    } else {
      widget.loadFromJson!().then((data) {
        if (data != null) {
          loadFromJson(data);
          selected = countries!.firstWhere(
            (x) => x.dial_code == "+${widget.initCountry}",
            orElse: () => countries!.firstWhere((x) => x.dial_code == "+966"),
          );
        } else {
          getAllCountry().then((value) => selected = countries!.firstWhere(
                (x) => x.dial_code == "+${widget.initCountry}",
                orElse: () =>
                    countries!.firstWhere((x) => x.dial_code == "+966"),
              ));
        }
      });
    }
    node = widget.phoneConfig.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.isShowCountryCode)
      Expanded(
        flex: 10,
        child: TextButton(
          onPressed: () {
            if (!widget.isDisableChangeCountryCode && !widget.inactive && countries != null) {
              bottomSheetX(
                isPaddingBottom: false,
                title: widget.dialogConfig.title,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: CountryCodeBottomSheet(
                      validate: widget.validate,
                      countries: countries!,
                      selected: selected,
                      onSelected: (countryCodeModel) {
                        setState(() {
                          selected = countryCodeModel;
                        });
                        if (widget.onInputChanged != null) {
                          widget.onInputChanged!(IntPhoneNumber(
                              code: selected.code,
                              dial_code: selected.dial_code,
                              number: widget.controller.text
                                  .trimLeft()
                                  .trimRight()));
                        }
                      },
                      dialogConfig: widget.dialogConfig,
                    ),
                  ),
                ),
              );
            }
          },
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Container(
            width: double.infinity,
            height: StyleX.inputHeight,
            decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.horizontal(
                  start: Radius.circular(StyleX.radius)),
              border: Border.all(
                width: StyleX.borderWidth,
                color: Theme.of(context).dividerColor,
              ),
              color: context.isDarkMode
                  ? ColorX.grey.shade800.withOpacity(0.6)
                  : ColorX.grey.shade100,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlagView(
                  countryCodeModel: selected,
                  isFlat: widget.countryConfig.flatFlag,
                  size: widget.countryConfig.flagSize,
                ),
                const SizedBox(width: 8),
                Text(
                  selected.dial_code,
                  style: widget.countryConfig.textStyle,
                ),
                if(!widget.isDisableChangeCountryCode)
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Theme.of(context).iconTheme.color,
                )
              ],
            ),
          ),
        ),
      ),
      Expanded(
        flex: 20,
        child: Directionality(
          textDirection: Directionality.of(Get.context!) == TextDirection.rtl ? TextDirection.rtl:TextDirection.ltr,
          child: TextFieldX(
            color: widget.phoneConfig.color,
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(StyleX.radius)),
            borderErrorRadius:
                const BorderRadius.horizontal(right: Radius.circular(StyleX.radius)),
            margin: EdgeInsets.zero,
            validate: widget.validate,
            hint: widget.phoneConfig.hintText ?? "",
            controller: widget.controller,
            textInputAction: widget.phoneConfig.textInputAction,
            // isActiveError:widget.isActiveError,
            label: widget.phoneConfig.labelText,
            textInputType: TextInputType.number,
            inputFormatters: [
              ...widget.inputFormatters,
              if (widget.formatter != null) widget.formatter!
            ],
            onChanged: (text) {
              if (widget.onInputChanged != null) {
                widget.onInputChanged!(IntPhoneNumber(
                    code: selected.code,
                    dial_code: selected.dial_code,
                    number: text.trimLeft().trimRight()));
              }
            },
          ),
        ),
      ),
    ]);
  }

  Future<void> getAllCountry() async {
    if (widget.loadFromJson != null) {
    } else {
      countries = await GeneralUtil.loadJson();
    }
    setState(() {});
  }

  void loadFromJson(String data) {
    Iterable jsonResult = json.decode(data);
    countries = List<CountryCodeModel>.from(jsonResult.map((model) {
      try {
        return CountryCodeModel.fromJson(model);
      } catch (e, stackTrace) {
        log("Json Converter Failed: ", error: e, stackTrace: stackTrace);
      }
    }));
    setState(() {});
  }
}

class IntPhoneNumber {
  String code, dial_code, number;
  IntPhoneNumber(
      {required this.code, required this.dial_code, required this.number});
  String get fullNumber => "$dial_code $number";
  String get rawNumber => number.replaceAll(" ", "");
  String get rawDialCode => dial_code.replaceAll("+", "");
  String get rawFullNumber =>
      fullNumber.replaceAll(" ", "").replaceAll("+", "");
}
