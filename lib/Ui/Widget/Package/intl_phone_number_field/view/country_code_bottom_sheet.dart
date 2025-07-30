import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../widget.dart';
import '../models/country_code_model.dart';
import '../models/dialog_config.dart';
import 'country_widget.dart';

class CountryCodeBottomSheet extends StatefulWidget {
  final List<CountryCodeModel> countries;
  final Function(CountryCodeModel countryCodeModel) onSelected;
  final CountryCodeModel? selected;
  final String? Function(String?)? validate;
  final DialogConfig dialogConfig;
  const CountryCodeBottomSheet(
      {super.key,
      required this.countries,
      required this.onSelected,
      this.selected,
      required this.validate,
      required this.dialogConfig});

  @override
  State<CountryCodeBottomSheet> createState() => _CountryCodeBottomSheetState();
}

class _CountryCodeBottomSheetState extends State<CountryCodeBottomSheet> {
  late List<CountryCodeModel> mainCountries, searchCountries;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    mainCountries = widget.countries;
    searchCountries = widget.countries.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldX(
            color: Theme.of(context).cardColor,
            validate: widget.validate,
            hint: widget.dialogConfig.searchHintText,
            controller: searchController,
            icon: Iconsax.search_normal_1,
            iconSize: 20,
            onChanged: (value) {
              search(value);
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                if (widget.selected != null &&
                    searchCountries.any(
                        (element) => element.code == widget.selected?.code))
                  InkWell(
                      onTap: () {
                        widget.onSelected(widget.selected!);
                        Navigator.pop(context);
                      },
                      child: CountryWidget(
                          countryCodeModel: widget.selected!,
                          isSelected: true,
                          dialogConfig: widget.dialogConfig).paddingSymmetric(horizontal: 10)),
                for (var country in searchCountries
                    .where((element) => element.code != widget.selected?.code))
                  InkWell(
                    onTap: () {
                        widget.onSelected(country);
                        Navigator.pop(context);
                      },
                      child: CountryWidget(
                          countryCodeModel: country,
                          isSelected: false,
                          dialogConfig: widget.dialogConfig,).paddingSymmetric(horizontal: 10),)
              ],
            ),
          )
        ],
      ),
    );
  }

  void search(String search) {
    searchCountries = mainCountries.where((element) =>  element.name.tr.toLowerCase().contains(search.tr.toLowerCase()) || element.dial_code.tr.toLowerCase().contains(search.tr.toLowerCase())).toList();
    setState(() {});
  }
}
