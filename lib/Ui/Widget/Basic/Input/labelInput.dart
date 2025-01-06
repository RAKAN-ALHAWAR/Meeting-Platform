part of '../../widget.dart';

class LabelInputX extends StatelessWidget {
  const LabelInputX(this.label,{super.key, this.marginTop = 6,this.marginBottom = 6, this.isRequired=false , this.isOptional=false });
  final String label;
  final double marginTop;
  final double marginBottom;
  final bool? isOptional;
  final bool? isRequired;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: marginBottom,top: marginTop),
          child: TextX(label,style: TextStyleX.titleSmall,),
        ),
        const SizedBox(width: 5),
        if(isRequired!=true && isOptional==true)
          TextX("(${"optional".tr})",style: TextStyleX.supTitleLarge,),
        if(isRequired??false)
          TextX("*",style: TextStyleX.supTitleLarge,),
      ],
    );
  }
}
