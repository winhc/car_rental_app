import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/digit_util.dart';
import '../modules/explore/models/car_model.dart';

class CarGridView extends StatelessWidget {
  CarGridView(
      {super.key,
      required this.onTap,
      required this.isLoading,
      this.carList = const []});

  final Function(Car car) onTap;
  final bool isLoading;
  List<Car> carList;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: isLoading
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.4),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: Colors.black26,
                  highlightColor: Colors.white10,
                  child: const Card(),
                );
              })
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.3),
              itemCount: carList.length,
              itemBuilder: (context, index) {
                Car car = carList[index];
                return GestureDetector(
                  onTap: () => onTap(car),
                  child: Card(
                    color: Colors.white,
                    elevation: 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Hero(
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
                                )
                                //  Image.asset(
                                //   "assets/images/porsche911coupe.jpeg",
                                //   fit: BoxFit.contain,
                                // ),
                                ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                                RatingBar.builder(
                                  itemSize: 16,
                                  initialRating: DigiUtil()
                                      .parseDigit(car.rentalRate ?? 0),
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
                                const SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      "${NumberFormat.decimalPattern().format(car.rentalRate ?? 0)} Ks",
                                      style: const TextStyle(
                                          color: Colors.deepPurple),
                                    ),
                                    const Text(" / Per Day")
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
