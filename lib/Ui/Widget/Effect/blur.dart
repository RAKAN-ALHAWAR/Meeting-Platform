part of '../widget.dart';

class BlurX extends StatelessWidget {
  const BlurX(
      {super.key,
        this.blur= StyleX.blur,
        this.radius,
        required this.child,

      });

  final double blur;
  final Widget child;
  final BorderRadiusGeometry? radius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius??BorderRadius.circular(StyleX.radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      ),
    );
  }
}