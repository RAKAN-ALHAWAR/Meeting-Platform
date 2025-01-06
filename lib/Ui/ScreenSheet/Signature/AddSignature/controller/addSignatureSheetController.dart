import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';

class AddSignatureSheetController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  RxBool isLoadingUpload = false.obs;
  RxBool isDone = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  final signatureVia = ValueNotifier(1);
  RxBool isImage = true.obs;

  Rx<XFile?> image = Rx<XFile?>(null);
  Rx<(String?, String?)> imageSize = Rx<(String?, String?)>((null, null));
  final ImagePicker picker = ImagePicker();
  RxBool isHasDrawing = false.obs;
  RxBool isOpenPenWidth = false.obs;
  RxInt drawingSteps = 0.obs;
  RxInt drawingCurrentSteps = 0.obs;
  RxDouble penStrokeWidth = 2.0.obs;

  late Rx<SignatureController> signatureController = SignatureController(
    penStrokeWidth: penStrokeWidth.value,
    strokeCap: StrokeCap.round,
    strokeJoin: StrokeJoin.round,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    onDrawEnd: () {
      isHasDrawing.value = true;
      drawingSteps.value++;
      drawingCurrentSteps.value = drawingSteps.value;
      isDone.value = true;
    },
  ).obs;

  //============================================================================
  // Functions

  uploadImage() async {
    /// Open the user's photo gallery to select a photo
    var x = await picker.pickImage(source: ImageSource.gallery);

    /// If an image is selected, the data is updated
    if (x != null) {
      isLoadingUpload.value = true;
      image.value = x;
      isDone.value = true;
      await getImageSize();
      update();
      isLoadingUpload.value = false;
    }
  }

  Future<void> getImageSize() async {
    try {
      imageSize.value = FunctionX.formatFileSize(await image.value!.length());
    } catch (e) {
      imageSize.value = (null, null);
    }
  }

  onTapPenWidth() {
    isOpenPenWidth.value = !isOpenPenWidth.value;
  }

  onChangePenWidth(double width) {
    if (penStrokeWidth.value != width) {
      penStrokeWidth.value = width;
      clearDraw();
      signatureController.value = SignatureController(
        penStrokeWidth: penStrokeWidth.value,
        strokeCap: StrokeCap.round,
        strokeJoin: StrokeJoin.round,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white,
        onDrawEnd: () {
          isHasDrawing.value = true;
          drawingSteps.value++;
          drawingCurrentSteps.value = drawingSteps.value;
          isDone.value = true;
        },
      );
    }
    isOpenPenWidth.value = false;
  }

  onDeleteImage(_) {
    image.value = null;
    imageSize.value = (null, null);
    isDone.value = false;
  }

  clearDraw() {
    signatureController.value.clear();
    isHasDrawing.value = false;
    drawingSteps.value = 0;
    drawingCurrentSteps.value = 0;
    isDone.value = false;
  }

  void redoDraw() {
    signatureController.value.redo();
    drawingSteps.value++;
    if (drawingSteps.value == 1) {
      isDone.value = true;
    }
  }

  void undoDraw() {
    signatureController.value.undo();
    drawingSteps.value--;
    if (drawingSteps.value == 0) {
      isDone.value = false;
      isHasDrawing.value = false;
    }
  }

  Future<File> imageToFile(ui.Image image) async {
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception("Failed to convert image to ByteData.");
    }
    final Uint8List bytes = byteData.buffer.asUint8List();
    final Directory tempDir = await getTemporaryDirectory();
    final String filePath = '${tempDir.path}/suggestion.png';
    final File file = File(filePath);
    await file.writeAsBytes(bytes);
    return file;
  }

  onSave() async {
    try {
      if (isLoading.isFalse) {
        buttonState.value = ButtonStateEX.loading;
        isLoading.value = true;
        var message = await DatabaseX.addSignature(
            image: isImage.value
                ? File(image.value!.path)
                : await imageToFile(
                    (await signatureController.value.toImage())!));
        try {
          app.user.value = await DatabaseX.getProfile();
        } catch (_) {}

        /// The time delay here is aesthetically beneficial
        buttonState.value = ButtonStateEX.success;
        await Future.delayed(
          const Duration(
            seconds: StyleX.successButtonSecond,
          ),
        );
        Get.back(result: true);
        if (message != null) {
          ToastX.success(message: message);
        }
      }
    } catch (e) {
      ToastX.error(message: e.toString());
    }
    isLoading.value = false;

    /// Reset the button state
    Timer(
      const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
      () {
        buttonState.value = ButtonStateEX.normal;
      },
    );
  }
  //============================================================================
  // Initialization

  @override
  void onInit() {
    super.onInit();

    /// listener if change tap for upload by image or drawing
    signatureVia.addListener(() {
      isImage.value = signatureVia.value == 1;
      if (isImage.value) {
        isDone.value = image.value != null;
      } else {
        isDone.value = drawingSteps.value != 0;
      }
    });
  }
}
