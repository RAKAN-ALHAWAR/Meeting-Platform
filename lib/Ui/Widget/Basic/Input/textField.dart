part of '../../widget.dart';

// ignore: must_be_immutable
class TextFieldX extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final int? hintMaxLines;
  final int? errorMaxLines;
  final bool disabled;
  final bool? onlyRead;
  final bool autofocus;
  final EdgeInsets margin;
  final IconData? icon;
  final Widget? prefixWidget;
  final double iconSize;
  final Color? colorText;
  final Color? color;
  final Color? borderColor;
  final BorderSide? border;
  final BorderRadiusGeometry? borderRadius;
  final BorderSide? borderError;
  final BorderRadiusGeometry? borderErrorRadius;
  final bool isPassword;
  final bool? isRequired;
  late int maxLines;
  late int minLines;
  late TextAlign? textAlign;
  final int? maxLength;
  final Widget? suffixWidget;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validate;
  final Function(String)? onChanged;
  final Function(bool)? onChangedFocus;
  final void Function(String value)? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  TextFieldX({
    super.key,
    required this.controller,
    this.label,
    this.isRequired,
    this.hint,
    this.hintMaxLines,
    this.errorMaxLines,
    this.validate,
    this.autofocus = false,
    this.textInputType,
    this.textInputAction,
    this.isPassword = false,
    this.onlyRead,
    this.margin = const EdgeInsets.symmetric(vertical: 5),
    this.icon,
    this.prefixWidget,
    this.iconSize = 24.0,
    this.disabled = false,
    this.colorText,
    this.color,
    this.borderColor,
    this.border,
    this.borderRadius,
    this.borderError,
    this.borderErrorRadius,
    this.textAlign,
    this.onChanged,
    this.onChangedFocus,
    this.onEditingComplete,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.suffixWidget,
    this.inputFormatters,
  }) {
    if (minLines > maxLines) {
      maxLines = minLines;
    }
  }

  @override
  State<TextFieldX> createState() => _TextFieldXState();
}

class _TextFieldXState extends State<TextFieldX> {
  late bool passwordVisible;
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  @override
  void initState() {
    passwordVisible = widget.isPassword;
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && widget.textInputAction == TextInputAction.done) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
      widget.onChangedFocus?.call(_focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderSide: widget.border ??
          BorderSide(
            width: StyleX.borderWidth,
            color: widget.borderColor ?? Theme.of(context).dividerColor,
          ),
      borderRadius: widget.borderRadius?.resolve(Directionality.of(context)) ?? BorderRadius.circular(StyleX.radius),
    );
    OutlineInputBorder borderError = OutlineInputBorder(
      borderSide: widget.borderError ??
          BorderSide(
            width: StyleX.borderWidth,
            color: Theme.of(context).colorScheme.error,
          ),
      borderRadius:
          widget.borderErrorRadius?.resolve(Directionality.of(context)) ?? BorderRadius.circular(StyleX.radius),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          LabelInputX(widget.label!, isRequired: widget.isRequired),
        Padding(
          padding: widget.margin,
          child: TextFormField(
            textAlign: widget.textAlign ?? TextAlign.start,
            maxLength: widget.maxLength,
            minLines: widget.minLines,
            style: TextStyleX.titleSmall.copyWith(color: widget.colorText??(widget.onlyRead??false?ColorX.grey.shade400:null)),
            autofocus: widget.autofocus,
            focusNode: _focusNode,
            onEditingComplete: (){
              widget.onEditingComplete?.call(widget.controller.text);
              if (widget.textInputAction == TextInputAction.next) {
                FocusScope.of(context).nextFocus();
              } else if (widget.textInputAction == TextInputAction.done) {
                FocusScope.of(context).unfocus();
              }
              },
            onChanged: (text) {
              if(widget.textInputType==TextInputType.number) {
                String convertedText = text.arabicToEnglishNumbers;
                widget.controller.text = convertedText;
                widget.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: convertedText.length),
                );
                if (widget.onChanged != null) {
                  widget.onChanged!(convertedText);
                }
              }else if (widget.onChanged != null) {
                widget.onChanged!(text);
              }
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 600), () async {
                widget.onEditingComplete?.call(text);
              });
            },
            validator: widget.validate,
            readOnly: widget.onlyRead ?? widget.disabled,
            obscureText: passwordVisible,
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
            textAlignVertical: TextAlignVertical.center,
            controller: widget.controller,
            inputFormatters: widget.inputFormatters,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.disabled
                  ? Theme.of(context).disabledColor
                  : widget.color ?? Theme.of(context).cardTheme.color,
              contentPadding: (widget.icon != null || widget.prefixWidget!=null)
                  ? const EdgeInsets.symmetric(vertical: 1, horizontal: 4)
                  : const EdgeInsetsDirectional.only(
                      start: 0, end: 16, top: 12, bottom: 12),
              enabledBorder: border,
              focusedBorder: border,
              disabledBorder: border,
              errorBorder: borderError,
              focusedErrorBorder: borderError,
              prefixIcon: widget.icon != null
                  ? Icon(
                      widget.icon,
                      size: widget.iconSize,
                      color: ColorX.grey.shade400,
                    )
                  : widget.prefixWidget ?? const SizedBox(),
              prefixIconConstraints: (widget.icon != null || widget.prefixWidget!=null)
                  ? null
                  : BoxConstraints.tight(
                      const Size(16, StyleX.inputHeight),
                    ),
              suffixIcon: widget.suffixWidget != null
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16),
                      child: widget.suffixWidget)
                  : (widget.isPassword
                      ? IconButton(
                          icon: Icon(
                            passwordVisible ? Iconsax.eye4 : Iconsax.eye_slash5,
                            color: ColorX.grey.shade300,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        )
                      : null),
              suffixIconConstraints:
                  const BoxConstraints(maxWidth: StyleX.inputHeight),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
              isCollapsed: true,
              errorStyle: TextStyleX.titleSmall,
              errorMaxLines: widget.errorMaxLines,
              alignLabelWithHint: true,
              hintText: (widget.hint ?? "").tr,
              hintMaxLines: widget.hintMaxLines,
              hintStyle: TextStyleX.titleSmall
                  .copyWith(color: Theme.of(context).hintColor),
            ),
          ),
        ),
      ],
    );
  }
}
