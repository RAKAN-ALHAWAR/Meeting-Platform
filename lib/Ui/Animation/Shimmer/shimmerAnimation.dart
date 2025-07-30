part of '../animation.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this class }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// It is used in animations that appear as loading while waiting
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class ShimmerAnimationX extends StatefulWidget {
  const ShimmerAnimationX(
      {super.key,
        this.margin=const EdgeInsets.only(right: 0.0),
        this.startColor,
        this.endColor,
        this.delayInMilliSeconds = const Duration(milliseconds: 0),
        this.width=double.maxFinite,
        this.isBorderRadius=true,
        required this.height,
        this.borderRadius = const BorderRadius.all(
          Radius.circular(StyleX.radius),
        ),
      });
  final double width;
  final double height;
  final Color? startColor;
  final Color? endColor;
  final BorderRadius borderRadius;
  final bool isBorderRadius;
  final EdgeInsetsGeometry margin;

  /// Accepts a [Duration] that would be the delay in starting the animation. Default value is [Duration(milliseconds: 0)]
  final Duration delayInMilliSeconds;

  /// Use this to create a round loading widget
  factory ShimmerAnimationX.round({
    required double size,
    Color? startColor = const Color(0xffE6E8EB),
    Color? endColor = const Color(0x77E6E8EB),
  }) =>
      ShimmerAnimationX(
        height: size,
        width: size,
        borderRadius: BorderRadius.all(
          Radius.circular(size / 2),
        ),
        startColor: startColor,
        endColor: endColor,
      );

  @override
  State<ShimmerAnimationX> createState() => _ShimmerAnimationXState();
}

class _ShimmerAnimationXState extends State<ShimmerAnimationX>
    with SingleTickerProviderStateMixin {
  // AnimationController for starting and driving the animation
  late AnimationController _animationController;
  // Animation which will hold the ColorTween values
  late Animation _colorAnimation;
  late Color startColor;
  late Color endColor;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
      startColor= widget.startColor??(Get.isDarkMode?ColorX.grey.shade700:ColorX.grey.shade100);
      endColor= widget.endColor??(Get.isDarkMode?ColorX.grey.shade800:ColorX.grey.shade200);

    // Initializing AnimationController
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 1));
    // ColorTween Animation
    _colorAnimation = ColorTween(begin: startColor, end: endColor)
        .animate(_animationController);

    // Trigger the animation only after build is rendered
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Check if any delay is requested
      if (widget.delayInMilliSeconds.inMilliseconds == 0) {
        _animationController.forward();
      } else {
        Future.delayed(widget.delayInMilliSeconds, () {
          // start the animation
          _animationController.forward();
        });
      }
    });

    // Adding listener to the AnimationController so that
    // we can put it in a loop based on it's status
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Reverse the animation if it's completed
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // Restart the animation if it's dismissed
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: widget.margin,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: widget.borderRadius,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose the AnimationController when the widget is disposed
    _animationController.dispose();
    super.dispose();
  }
}
