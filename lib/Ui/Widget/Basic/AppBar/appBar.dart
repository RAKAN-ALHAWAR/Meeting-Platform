part of '../../widget.dart';

class AppBarX extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String? title;
  final List<Widget>? actions;
  final bool isBack;
  final Color? color;
  final Color? backgroundColor;

  const AppBarX({
    super.key,
    this.title,
    this.height = StyleX.appBarHeight,
    this.actions,
    this.isBack = true,
    this.color,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? TextX(
              title!,
              style: TextStyleX.titleLarge,
            ).fadeAnimation100
          : null,
      surfaceTintColor: Colors.transparent,
      actions: actions,
      leadingWidth: 100,
      leading: isBack
          ? BackButtonX(color: color).fadeAnimation100
          : const SizedBox(),
      centerTitle: true,
      toolbarHeight: StyleX.appBarPaddingTop,
    );
  }
}
