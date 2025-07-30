part of '../../widget.dart';

class BackButtonX extends StatelessWidget {
  const BackButtonX({this.onTap, this.color, this.background, super.key});
  final Function()? onTap;
  final Color? color;
  final Color? background;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: StyleX.hPaddingApp,
          ),
          child: InkWell(
            onTap: onTap ?? Get.back,
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: background??ColorX.grey.shade100,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Icon(
                  size: 20,
                  Icons.arrow_back_ios_new_rounded,
                  color: color??(context.isDarkMode?null:ColorX.grey.shade700),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
