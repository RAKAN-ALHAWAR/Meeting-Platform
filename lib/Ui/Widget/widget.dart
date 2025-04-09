library;

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Core/Extension/date_time.dart';
import 'package:meeting/Data/Enum/notification_type_status.dart';
import 'package:meeting/Ui/Animation/fade/fade_animation.dart';
import 'package:meeting/Ui/Widget/Package/intl_phone_number_field/intl_phone_number_field.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../Config/Translation/translation.dart';
import '../../Core/core.dart';
import '../../Config/config.dart';
import '../../Data/Model/basic/root_page.dart';
import '../../Data/Model/notification/notification.dart';
import '../../Data/data.dart';
import 'package:intl/intl.dart' as intl;
import '../Animation/animation.dart';
import '../Screen/Root/controller/controller.dart';
import 'Package/flutter_advanced_segment/flutter_advanced_segment.dart';

part 'Basic/Other/layoutWidget.dart';
part 'Basic/Other/text.dart';
part 'Basic/AppBar/appBar.dart';
part 'Basic/AppBar/appBarRoot.dart';
part 'Basic/Cards/notificationCard.dart';
part 'Basic/Button/floatingActionButton.dart';
part 'Basic/Other/container.dart';
part 'Basic/Other/containerWeb.dart';
part 'Basic/Button/button.dart';
part 'Basic/Button/buttonState.dart';
part 'Basic/Input/textField.dart';
part 'Basic/Input/dropdown.dart';
part 'Effect/blur.dart';
part 'Effect/glass.dart';
part 'Basic/Other/selectionArea.dart';
part 'Basic/Alert/alertDialog.dart';
part 'Basic/Alert/bottomSheet.dart';
part 'Basic/Alert/toast.dart';
part 'Basic/Input/textFieldDate.dart';
part 'Basic/Input/checkBox.dart';
part 'Basic/Utils/addParent.dart';
part 'Basic/Other/imageNetwork.dart';
part 'Custom/Other/tabSegment.dart';
part 'Basic/Input/phoneField.dart';
part 'Custom/BottomSheet/dangerous.dart';
part 'Custom/BottomSheet/success.dart';
part 'Basic/Input/radioButton.dart';
part 'Basic/Input/labelInput.dart';
part "Basic/Input/multipleSelectionCard.dart";
part "Basic/Input/switch.dart";
part 'Basic/AppBar/appBarTransparent.dart';
part 'Basic/Other/dashLine.dart';
part 'Basic/Other/accordion.dart';
part 'Basic/Button/backButton.dart';
part 'Basic/Input/timePicker.dart';
part 'Basic/Input/datePicker.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// It contains all the common widgets in the project
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
