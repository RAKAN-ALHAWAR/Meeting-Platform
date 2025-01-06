import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:meeting/Config/Translation/translation.dart';
import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Data/Enum/delegate_status_status.dart';
import 'package:meeting/Data/Model/delegate/delegate.dart';
import '../../../../Config/config.dart';
import '../../widget.dart';

class DelegateCardX extends StatelessWidget {
  const DelegateCardX({super.key, required this.delegate, this.onAccept, this.onReject});
  final DelegateX delegate;
  final Function(DelegateX)? onAccept;
  final Function(DelegateX)? onReject;
  @override
  Widget build(BuildContext context) {
    MaterialColor color = delegate.status == DelegateStatusStatusX.accepted
        ? ColorX.green:delegate.status == DelegateStatusStatusX.rejected?
    ColorX.red:ColorX.yellow;
    return ContainerX(
      radius: StyleX.radiusLg,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      isBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (delegate.delegated != null)
            ContainerX(
              isBorder: true,
              radius: 100,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 16,
              ),
              color: color.shade50,
              borderColor: color.shade300,
              child: TextX(
                delegate.status.name,
                style: TextStyleX.supTitleLarge,
                color: color.shade500,
              ),
            ),
          /// TODO: اضافة اسم الموكل له هنا بدل الموكل
          Row(
            children: [
              TextX(
                '${'The client'.tr} : ',
                color: ColorX.grey.shade500,
                fontWeight: FontWeight.w400,
              ),
              Flexible(
                child: TextX(
                  delegate.attendance.user?.name ?? '',
                  maxLines: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextX(
                '${'The meeting'.tr} : ',
                color: ColorX.grey.shade500,
                fontWeight: FontWeight.w400,
              ),
              Flexible(
                child: TextX(
                  delegate.attendance.meeting?.title ?? '',
                  maxLines: 1,
                  color: ColorX.blue.shade500,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ).marginSymmetric(vertical: 10),
          Row(
            children: [
              Icon(
                Iconsax.calendar_1,
                color: ColorX.grey.shade400,
                size: 20,
              ),
              const SizedBox(width: 8),
              if (delegate.attendance.meeting?.date != null)
                TextX(
                  DateFormat(
                    'EEEE, d MMMM yyyy',
                    TranslationX.getLanguageCode,
                  ).format(delegate.attendance.meeting!.date!),
                  color: ColorX.grey.shade500,
                  fontWeight: FontWeight.w400,
                  size: 14,
                ),
            ],
          ),
          Row(
            children: [
              Icon(
                Iconsax.clock,
                color: ColorX.grey.shade400,
                size: 18,
              ),
              const SizedBox(width: 8),
              if (delegate.attendance.meeting?.startAt != null &&
                  delegate.attendance.meeting?.endAt != null)
                TextX(
                  '${DateFormat('hh:mm a', TranslationX.getLanguageCode).format(delegate.attendance.meeting!.startAt.toDateTimeX)} - ${DateFormat('hh:mm a', TranslationX.getLanguageCode).format(delegate.attendance.meeting!.endAt.toDateTimeX)}',
                  color: ColorX.grey.shade500,
                  fontWeight: FontWeight.w400,
                  size: 14,
                ),
            ],
          ).marginSymmetric(vertical: 10),
          Row(
            children: [
              Icon(
                Iconsax.video,
                color: ColorX.grey.shade400,
                size: 18,
              ),
              const SizedBox(width: 8),
              if (delegate.attendance.meeting?.place?.name !=null)
                TextX(
                  delegate.attendance.meeting!.place!.name,
                  color: ColorX.grey.shade500,
                  fontWeight: FontWeight.w400,
                  size: 14,
                ),
            ],
          ),
          if (delegate.status == DelegateStatusStatusX.waitingForApproval && onAccept!=null && onReject!=null)
          Row(
            children: [
              Flexible(
                child: ButtonX(
                  marginVertical: 0,
                  onTap: ()async=>await onAccept!(delegate),
                  text: "Accept",
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: ButtonX.dangerous(
                  marginVertical: 0,
                  onTap: ()async=>await onReject!(delegate),
                  text: "Reject",
                ),
              ),
            ],
          ).paddingOnly(top: 16)
        ],
      ),
    );
  }
}
