part of '../../widget.dart';

class RadioButtonX<T> extends StatelessWidget {
  const RadioButtonX(
      {super.key,
      required this.groupValue,
      required this.value,
      required this.onChanged,
      this.label,
      this.isCardOnly = false,
      this.check,
      this.child,
      this.height,
      this.valueCheck,
      this.color,
      this.margin = const EdgeInsets.symmetric(vertical: 5)});
  final String? label;
  final Widget? child;
  final bool isCardOnly;
  final double? height;
  final EdgeInsets margin;
  final Color? color;
  final T? groupValue;
  final T value;
  final dynamic valueCheck;
  final bool Function()? check;
  final void Function(T? value) onChanged;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: ContainerX(
        margin: margin,
        isBorder: true,
        color: (check!=null?check!():value.hashCode == groupValue.hashCode)
            ? context.isDarkMode
                ? ColorX.primary.shade900.withOpacity(0.3)
                : Theme.of(context).colorScheme.onPrimary
            : color ?? Theme.of(context).cardTheme.color,
        borderColor: (check!=null?check!():value.hashCode == groupValue.hashCode)
            ? context.isDarkMode?Theme.of(context).primaryColor:ColorX.primary.shade700
            : null,
        padding: isCardOnly ? const EdgeInsets.symmetric(horizontal: 20,vertical: 14.0) : EdgeInsets.zero,
        height: height??StyleX.inputHeight,
        child: Row(
          mainAxisAlignment:
              isCardOnly ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (!isCardOnly)
              Radio(
                value: valueCheck??value.hashCode,
                groupValue: groupValue.hashCode,
                fillColor: WidgetStateProperty.all(
                  (check!=null?check!():value.hashCode == groupValue.hashCode)
                      ? Theme.of(context).primaryColor
                      : ColorX.grey.shade300,
                ), // Change the fill color when selected
                splashRadius: 25, // Change the splash radius when clicked
                onChanged: (_) => onChanged(value),
              ),
            Flexible(
              child: child??TextX(
                label??'',
                color: (check!=null?check!():value.hashCode == groupValue.hashCode)
                    ? Theme.of(context).primaryColor
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
