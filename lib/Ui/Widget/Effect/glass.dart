part of '../widget.dart';

class GlassX extends StatelessWidget {
  const GlassX(
      {super.key,
        this.blur= StyleX.blur,
        this.opacity=0.15,
        this.radius,
        required this.child, this.isLight=false,

      });

  final double blur;
  final bool isLight;
  final double opacity;
  final Widget child;
  final BorderRadiusGeometry? radius;
  @override
  Widget build(BuildContext context) {
    var color =isLight?(context.isDarkMode?Colors.white:ColorX.grey.shade100):Colors.white;
    return ClipRRect(
      borderRadius: radius??BorderRadius.circular(StyleX.radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius??BorderRadius.circular(StyleX.radius),
            border: Border.all(width: 1.5,color: color.withOpacity(0.2)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(opacity),
                  color.withOpacity(opacity/3),
                ]),
          ),
          child: child,
        ),
      ),
    );
  }
}