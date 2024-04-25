import 'package:bankpfe/controllers/card_controller/scan_qr_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCode extends StatelessWidget {
  const ScanQrCode({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ScanQrControllerImp());
    return GetBuilder<ScanQrControllerImp>(
      builder: (controller) => Scaffold(
        body: Stack(
          children: [
            QRView(
              onQRViewCreated: controller.onQRViewCreated,
              key: controller.qrKey,
            ),
            Positioned(
              top: 30.0,
              left: 10.0,
              child: Row(
                children: [
                  IconButton(
                    iconSize: 28.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    "Scan Your Qr Code",
                    style: GoogleFonts.mulish(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
