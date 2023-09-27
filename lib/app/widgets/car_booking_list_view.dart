import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/app/modules/rent/models/booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../modules/explore/models/car_model.dart';

class CarBookingListView extends StatelessWidget {
  CarBookingListView(
      {super.key,
      required this.onTap,
      required this.isLoading,
      this.bookingList = const []});

  final Function(Booking booking) onTap;
  final bool isLoading;
  List<Booking> bookingList;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: isLoading
          ? ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: Colors.black26,
                  highlightColor: Colors.white10,
                  child: Card(
                    color: Colors.white,
                    elevation: 0.8,
                    child: Row(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            padding: const EdgeInsets.all(8),
                            height: 140,
                            child: const Card()),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              BookingLabel(
                                  iconData: Icons.av_timer_rounded,
                                  value: "",
                                  valueColor: Colors.deepPurple),
                              const SizedBox(
                                height: 5,
                              ),
                              BookingLabel(
                                  iconData: Icons.confirmation_num,
                                  value: "",
                                  valueColor: Colors.deepPurple),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
          : ListView.builder(
              itemCount: bookingList.length,
              itemBuilder: (context, index) {
                Booking booking = bookingList[index];
                Car car = booking.car!;
                return GestureDetector(
                  onTap: () => onTap(booking),
                  child: Card(
                    color: Colors.white,
                    elevation: 0.8,
                    child: Row(
                      children: [
                        Hero(
                          tag: "image${car.id}",
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              padding: const EdgeInsets.all(8),
                              height: 140,
                              child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                imageUrl: "${car.imgUrl}",
                                placeholder: (context, url) =>
                                    const CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${car.brand} ${car.model}",
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              BookingLabel(
                                  iconData: Icons.av_timer_rounded,
                                  value: "${booking.duration} days",
                                  valueColor: Colors.deepPurple),
                              const SizedBox(
                                height: 5,
                              ),
                              BookingLabel(
                                  iconData: Icons.confirmation_num,
                                  value:
                                      "${NumberFormat.decimalPattern().format(booking.amount ?? 0)} Ks",
                                  valueColor: Colors.deepPurple),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  Widget BookingLabel(
      {required IconData iconData,
      required String value,
      required Color valueColor}) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.black54,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: TextStyle(color: valueColor),
        ),
      ],
    );
  }
}
