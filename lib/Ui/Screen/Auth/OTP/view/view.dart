import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Widget/Package/otp_pin_field_widget/src/otp_pin_field_input_type.dart';
import '../../../../Widget/Package/otp_pin_field_widget/src/otp_pin_field_style.dart';
import '../../../../Widget/Package/otp_pin_field_widget/src/otp_pin_field_widget.dart';
import '../../AuthLayout/authLayout.dart';
import '../controller/controller.dart';

class OTPView extends GetView<OTPController> {
  const OTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayoutX(
      title: 'Confirmation code',
      subtitle:
          'Please enter the confirmation code sent to your email to complete the process',
      child: Obx(
        () => AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: Column(
            children: [
              /// Code Field
              SizedBox(
                height: 60,
                width: Get.width,
                child: Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                          child: SizedBox(
                        height: 60,
                        width: Get.width,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: OtpPinField(
                            key: controller.otpKey,
                            fieldHeight: 54,
                            fieldWidth: 58,
                            textInputAction: TextInputAction.done,
                            maxLength: 6,
                            showCursor: true,
                            cursorColor: ColorX.primary,
                            cursorWidth: 2,
                            mainAxisAlignment: MainAxisAlignment.center,
                            otpPinFieldDecoration: OtpPinFieldDecoration.custom,
                            onChange: (val) {
                              if (val.length == 6) {
                                controller.otpCode.text = val;
                                controller.isDoneInput.value = true;
                              } else {
                                controller.otpCode.text = '';
                                controller.isDoneInput.value = false;
                              }
                            },
                            otpPinFieldStyle: OtpPinFieldStyle(
                              showHintText: false,
                              defaultFieldBackgroundColor:
                                  Theme.of(context).cardTheme.color ??
                                      Colors.transparent,
                              activeFieldBackgroundColor:
                                  Theme.of(context).cardTheme.color ??
                                      Colors.transparent,
                              activeFieldBorderColor: ColorX.primary,
                              defaultFieldBorderColor: ColorX.grey.shade200,
                              filledFieldBorderColor: ColorX.grey.shade200,
                              fieldBorderWidth: StyleX.borderWidth,
                              fieldPadding: 8,
                              fieldBorderRadius: 8,
                              textStyle: TextStyleX.titleMedium.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ).fadeAnimation250.marginOnly(bottom: 24),

              /// Button Login
              ButtonStateX(
                onTap: controller.onVerify,
                state: controller.buttonState.value,
                text: 'Verify',
                disabled: controller.isDoneInput.isFalse,
                colorDisabledButton: context.isDarkMode
                    ? ColorX.primary.shade300.withOpacity(0.2)
                    : ColorX.primary.withOpacity(0.4),
                colorDisabledBorder: Colors.transparent,
                colorDisabledText:
                    context.isDarkMode ? Colors.white38 : Colors.white,
              ).fadeAnimation300,

              const SizedBox(height: 22.0),

              /// Resend Code
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!controller.isResendAgain.value &&
                      !controller.isLoadingResendAgain.value)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Title
                        TextX(
                          "Didn't receive the code",
                          color: Theme.of(context).colorScheme.secondary,
                          style: TextStyleX.titleMedium,
                        ),
                        const SizedBox(width: 5),

                        /// Resend Time
                        Row(
                          children: [
                            TextX(
                              "( ",
                              color: Theme.of(context).colorScheme.secondary,
                              style: TextStyleX.titleMedium,
                            ),
                            TextX(
                              FunctionX.formatTime(controller.start.value),
                              style: TextStyleX.titleMedium,
                              color: ColorX.primary.shade700,
                            ),
                            TextX(
                              " ) ",
                              color: Theme.of(context).colorScheme.secondary,
                              style: TextStyleX.titleMedium,
                            ),
                            TextX(
                              "?",
                              color: Theme.of(context).colorScheme.secondary,
                              style: TextStyleX.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ).fadeAnimation400,
                  if (!controller.isResendAgain.value &&
                      !controller.isLoadingResendAgain.value)
                    const SizedBox(height: 8),
                  if (!controller.isLoadingResendAgain.value)

                    /// Resend Button
                    AbsorbPointer(
                      absorbing: !controller.isResendAgain.value,
                      child: InkWell(
                        onTap: controller.onResend,
                        borderRadius: BorderRadius.circular(StyleX.radius),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 1.0,
                            horizontal: 5,
                          ),
                          child: TextX(
                            "Resend code",
                            color: controller.isResendAgain.value
                                ? Theme.of(context).primaryColor
                                : ColorX.grey.shade300,
                            style: TextStyleX.titleMedium,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ).fadeAnimation450,
                    ),

                  /// Resend Loading
                  if (controller.isLoadingResendAgain.value)
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
