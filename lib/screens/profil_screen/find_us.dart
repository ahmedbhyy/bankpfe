import 'package:bankpfe/controllers/profil_controllers/find_us_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindUs extends StatelessWidget {
  const FindUs({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FindUsControllerImp());
    return GetBuilder<FindUsControllerImp>(
      builder: (findcontroller) => Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              markers: findcontroller.mymarkers,
              initialCameraPosition: findcontroller.kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                if (!findcontroller.googlecontroller.isCompleted) {
                  findcontroller.googlecontroller.complete(controller);
                }
              },
            ),
            Positioned(
              top: 30.0,
              left: 10.0,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    "Find Us",
                    style: GoogleFonts.mulish(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 350.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        ...List.generate(
                          findcontroller.bnanames.length,
                          (index) => Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await findcontroller.goToThebna(
                                    findcontroller.bnadistances[index]["long"],
                                    findcontroller.bnadistances[index]["lat"],
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    findcontroller.bnanames[index],
                                    style: const TextStyle(
                                      color: Color(0xff00aa86),
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  leading:
                                      const Icon(Icons.location_city_outlined),
                                  subtitle: Text(
                                    "${findcontroller.distancebetwwen(findcontroller.bnadistances[index]["lat"], findcontroller.bnadistances[index]["long"])} KM",
                                  ),
                                  trailing: Image.asset(
                                    "images/bna.png",
                                    height: 40.0,
                                  ),
                                ),
                              ),
                              const Divider(
                                endIndent: 40.0,
                                indent: 40.0,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          label: const Text(
            'Find Us',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(
            Icons.directions,
            color: Color.fromARGB(255, 98, 96, 96),
          ),
          backgroundColor: const Color(0xff00aa86),
        ),
      ),
    );
  }
}
