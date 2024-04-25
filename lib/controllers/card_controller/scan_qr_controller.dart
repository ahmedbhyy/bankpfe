import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

abstract class ScanQrController extends GetxController {
  void onQRViewCreated(QRViewController controller);
}

class ScanQrControllerImp extends ScanQrController {
  late GlobalKey qrKey;
  QRViewController? controllerqr;
  Barcode? result;

  @override
  onQRViewCreated(controller) {
    controllerqr = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      update();
      Get.back();
      Get.rawSnackbar(
          title: "Success",
          message:
              "you new card has been added successfully with ${result!.code}",
          backgroundColor: const Color(0xff00aa86));
    });
  }

  @override
  void dispose() {
    controllerqr?.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    qrKey = GlobalKey(debugLabel: 'QR');
    super.onInit();
  }
}
