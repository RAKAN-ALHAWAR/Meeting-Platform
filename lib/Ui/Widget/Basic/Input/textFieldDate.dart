part of '../../widget.dart';

class TextFieldDateX extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final String? titleBottomSheet;
  final bool disabled;
  final EdgeInsets margin;
  final IconData? icon;
  final Color? color;
  final DateTime? lastDate;
  final DateTime? firstDate;
  final DateTime? initialDate;
  final String? Function(String?)? validate;
  final Function(DateTime?)? onChange;
  late final Locale locale;

  TextFieldDateX({
    super.key,
    required this.controller,
    required this.hint,
    this.validate,
    this.initialDate,
    this.color,
    this.firstDate,
    this.lastDate,
    this.label,
    this.disabled = false,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.icon,
    this.onChange,
    this.titleBottomSheet,
    Locale? locale,
  }) {
    this.locale = locale ?? Locale(TranslationX.getLanguageCode);
  }

  @override
  State<TextFieldDateX> createState() => _TextFieldDateXState();
}

class _TextFieldDateXState extends State<TextFieldDateX> {
  DateTime? date;
  TimeOfDay time = const TimeOfDay(hour: 1, minute: 0);
  @override
  void initState() {
    initializeDateFormatting(widget.locale.languageCode, null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null) LabelInputX(widget.label!),
        ContainerX(
          margin: widget.margin,
          padding: widget.icon != null
              ? const EdgeInsets.symmetric(vertical: 1, horizontal: 4)
              : const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
          isBorder: true,
          color: widget.disabled
              ? Theme.of(context).disabledColor
              : widget.color ?? Theme.of(context).cardTheme.color,
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validate,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.done,
            style: TextStyleX.titleSmall,
            focusNode: AlwaysDisabledFocusNode(),
            readOnly: true,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              prefixIcon: widget.icon != null
                  ? Icon(
                      widget.icon,
                      size: 22.0,
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  : null,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
              hintText: widget.hint.tr,
              isCollapsed: true,
              hintStyle: TextStyleX.titleSmall
                  .copyWith(color: Theme.of(context).hintColor),
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              await bottomSheetX(
                title: widget.titleBottomSheet,
                child: Column(
                  children: [
                    DatePickerX(
                      initialDate: widget.initialDate,
                      firstDate: widget.firstDate,
                      lastDate: widget.lastDate,
                      selectedDate: date,
                      firstDayOfWeek: DateTime.saturday,
                      onDateSelected: (newDate) {
                        date = newDate;
                      },
                    ).fadeAnimation200,
                    const SizedBox(height: 10),
                    Center(
                      child: TimeInputX(
                        initialTime: time,
                        onChange: (time) => this.time=time,
                      ),
                    ).fadeAnimation250,
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          child: ButtonX(
                            text: "Ok",
                            onTap: () {
                              widget.controller.text = (date != null
                                  ? (intl.DateFormat('EEEE، d MMMM y', 'ar')
                                          .format(date!))
                                      .arabicToEnglishNumbers
                                  : '');
                              if (widget.onChange != null) {
                                widget.onChange!(date?.addTime(time));
                              }
                              Get.back();
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: ButtonX.gray(
                            text: "Reset",
                            onTap: () {
                              widget.controller.text = '';
                              date=null;
                              time=const TimeOfDay(hour: 1, minute: 0);
                              widget.onChange!(null);
                              Get.back();
                            },
                          ),
                        )
                      ],
                    ).fadeAnimation300
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
