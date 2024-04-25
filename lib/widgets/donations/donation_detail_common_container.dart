import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/pay_controllers/donation_details_controller.dart';
import '../generalwidgets/common_container_bills.dart';

class DonationDetailsContainer extends GetView<DonationsDetailsControllerImp> {
  final String mytitle;
  final String by;
  final String byinfo;
  final String description;

  final String place;
  final int giver;
  final double amount;
  final double estimateamount;
  final String orgonaizedbyimage;
  final String orgonizedbylink;
  const DonationDetailsContainer(
      this.mytitle,
      this.giver,
      this.amount,
      this.estimateamount,
      this.by,
      this.byinfo,
      this.description,
      this.place,
      this.orgonaizedbyimage,
      this.orgonizedbylink,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainerBills(
      mywidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mytitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              const Icon(
                Icons.person_3_outlined,
                color: Color(0xff00aa86),
              ),
              Text(
                "$giver Giver",
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                "$amount TND / $estimateamount TND",
                style: const TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: const SliderThemeData(
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
            ),
            child: Slider(
              value: amount,
              max: estimateamount,
              activeColor: const Color(0xff00aa86),
              onChanged: (double value) {},
            ),
          ),
          Text(
            "Orgonized by",
            style: GoogleFonts.mulish(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const SizedBox(height: 5.0),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 230, 222, 222),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        by,
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      const Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 15.0,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    iconSize: 20.0,
                    onPressed: () {
                      controller.openmaps(orgonizedbylink);
                    },
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                  ),
                  subtitle: const Text("Tunis"),
                  leading: CachedNetworkImage(
                    imageUrl: orgonaizedbyimage,
                    width: 40.0,
                  ),
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 55.0,
                child: IconButton(
                  onPressed: () {
                    Get.rawSnackbar(
                      title: by,
                      duration: const Duration(seconds: 8),
                      message: byinfo,
                      backgroundColor: const Color(0xff00aa86),
                      icon: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                    );
                  },
                  iconSize: 23.0,
                  icon: const Icon(
                    Icons.info,
                    color: Color(0xff00aa86),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            "Description",
            style: GoogleFonts.mulish(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(description),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Place",
                style: GoogleFonts.mulish(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              TextButton.icon(
                label: Text(
                  "Open Google Maps",
                  style: GoogleFonts.mulish(
                    fontSize: 13.0,
                    color: const Color.fromARGB(255, 141, 137, 137),
                  ),
                ),
                onPressed: () {
                  controller.openmaps(place);
                },
                icon: const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xff00aa86),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Center(
            child: InkWell(
              onTap: () {
                controller.openmaps(place);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "images/mosqueplace.png",
                  height: 200.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
