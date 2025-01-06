part of '../../widget.dart';

class AccordionX extends StatefulWidget {
  const AccordionX({
    super.key,
    required this.title,
    this.onTap,
    required this.child,
    this.margin = const EdgeInsets.only(bottom: 10),
    this.headColor,
    this.headOpenColor,
    this.bodyColor,
    this.isOpen = false,
  });
  final String title;
  final Function(bool val)? onTap;
  final Widget child;
  final Color? headColor;
  final Color? headOpenColor;
  final Color? bodyColor;
  final bool isOpen;
  final EdgeInsetsGeometry margin;
  @override
  State<AccordionX> createState() => _AccordionXState();
}

class _AccordionXState extends State<AccordionX> {
  bool isOpen = false;
  @override
  void initState() {
    isOpen = widget.isOpen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: widget.bodyColor ?? Theme.of(context).cardColor,
      padding: EdgeInsets.zero,
      margin: widget.margin,
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              setState(() {
                isOpen = !isOpen;
              });
              if (widget.onTap != null) {
                await widget.onTap!(isOpen);
              }
            },
            child: Container(
              color: isOpen
                  ? widget.headOpenColor ??
                      (context.isDarkMode?ColorX.primary.shade500:ColorX.grey.shade100)
                  : widget.headColor ?? Theme.of(context).cardColor,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: StyleX.accordionHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextX(
                      widget.title,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      color: ColorX.primary,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    isOpen
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down,
                    color: (isOpen && context.isDarkMode)?Colors.white:Theme.of(context).colorScheme.secondary,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            child: isOpen ? widget.child : null,
          ).sizeAnimation300,
        ],
      ),
    );
  }
}
