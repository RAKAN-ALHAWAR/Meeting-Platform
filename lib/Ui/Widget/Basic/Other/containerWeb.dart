part of '../../widget.dart';

class ContainerWebX extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double maxWidth;
  final double minWidth;
  final Color? color;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final bool isBorderColor;
  const ContainerWebX({
    this.width,
    this.maxWidth = 500,
    this.minWidth = 0.0,
    this.isBorderColor = true,
    this.height,
    this.color,
    this.padding,
    this.margin = const EdgeInsets.symmetric(vertical: 20),
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
            maxWidth: kIsWeb ? maxWidth : double.infinity, minWidth: minWidth),
        padding:
            kIsWeb ? padding ?? const EdgeInsets.all(14.0) : EdgeInsets.zero,
        margin: kIsWeb ? margin : null,
        width: kIsWeb ? width : null,
        height: kIsWeb ? height : null,
        decoration: kIsWeb
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: isBorderColor
                    ? Border.all(width: 0.5, color: ColorX.primary.shade500)
                    : null,
                color: color ?? Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 6),
                    color: Theme.of(context).colorScheme.secondary,
                    blurRadius: 12,
                  )
                ],
              )
            : null,
        child: child,
      ),
    );
  }
}
