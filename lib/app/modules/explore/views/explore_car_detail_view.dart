import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/digit_util.dart';
import '../controllers/explore_controller.dart';

class ExploreCarDetailView extends GetView<ExploreController> {
  const ExploreCarDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                controller.onFavouriteIconClick();
              },
              icon: Obx(() => Icon(controller.isFavourite.value
                  ? CupertinoIcons.heart_fill
                  : CupertinoIcons.heart)))
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
                  imageUrl: "${controller.selectedCar.value.imgUrl}",
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
                    "${controller.selectedCar.value.brand} ${controller.selectedCar.value.model}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        itemSize: 16,
                        initialRating: DigiUtil().parseDigit(
                            controller.selectedCar.value.rentalRate ?? 0),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Badge(
                        label: Text(
                          "${controller.selectedCar.value.status}",
                        ),
                      )
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
                      description: "${controller.selectedCar.value.brand}"),
                  SpecificationCard(
                      title: "Model",
                      description: "${controller.selectedCar.value.model}"),
                  SpecificationCard(
                      title: "Number",
                      description:
                          "${controller.selectedCar.value.registrationNo}"),
                  SpecificationCard(
                      title: "Door count",
                      description: "${controller.selectedCar.value.doorCount}"),
                  SpecificationCard(
                      title: "Seat count",
                      description: "${controller.selectedCar.value.seatCount}"),
                  SpecificationCard(
                      title: "Fuel type",
                      description: "${controller.selectedCar.value.fuelType}"),
                  SpecificationCard(
                      title: "Gearbox type",
                      description:
                          "${controller.selectedCar.value.gearBoxType}"),
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
                '${controller.selectedCar.value.details}',
                style: const TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12)),
                child: Center(
                    child: Wrap(
                  children: [
                    Text(
                      "${NumberFormat.decimalPattern().format(controller.selectedCar.value.rentalRate ?? 0)} Ks",
                      style: const TextStyle(
                          color: Colors.deepPurple, fontSize: 16),
                    ),
                    const Text(" / Per Day")
                  ],
                )),
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  controller.onClickRentNowButton(context);
                },
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text(
                    "Rent Now",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ))
            ],
          ),
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
