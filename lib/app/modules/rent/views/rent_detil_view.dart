import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/app/modules/rent/controllers/rent_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RentCarDetailView extends GetView<RentController> {
  const RentCarDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                controller.onClickDateIconButton(context);
              },
              icon: const Icon(Icons.date_range))
        ],
      ),
      body: Obx(
        () => ListView(
          children: [
            Hero(
              tag: controller.heroTagName,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                height: 250,
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: "${controller.selectedBooking.value.car!.imgUrl}",
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${controller.selectedBooking.value.car!.brand} ${controller.selectedBooking.value.car!.model}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    children: [
                      const Text("From"),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        ": ${controller.selectedBooking.value.startDate}",
                        style: const TextStyle(color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      const Text("To"),
                      const SizedBox(
                        width: 29,
                      ),
                      Text(
                        ": ${controller.selectedBooking.value.endDate}",
                        style: const TextStyle(color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Specification',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SpecificationCard(
                      title: "Brand",
                      description:
                          "${controller.selectedBooking.value.car!.brand}"),
                  SpecificationCard(
                      title: "Model",
                      description:
                          "${controller.selectedBooking.value.car!.model}"),
                  SpecificationCard(
                      title: "Number",
                      description:
                          "${controller.selectedBooking.value.car!.registrationNo}"),
                  SpecificationCard(
                      title: "Door count",
                      description:
                          "${controller.selectedBooking.value.car!.doorCount}"),
                  SpecificationCard(
                      title: "Seat count",
                      description:
                          "${controller.selectedBooking.value.car!.seatCount}"),
                  SpecificationCard(
                      title: "Fuel type",
                      description:
                          "${controller.selectedBooking.value.car!.fuelType}"),
                  SpecificationCard(
                      title: "Gearbox type",
                      description:
                          "${controller.selectedBooking.value.car!.gearBoxType}"),
                ],
              ),
            ),
            // Detail description
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'Description',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '${controller.selectedBooking.value.car!.details}',
                style: const TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.onDeleteBookingClick(context);
        },
        child: const Icon(
          CupertinoIcons.delete,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget SpecificationCard(
      {required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Card(
        elevation: 0.5,
        child: Container(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
              Text(
                description,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
