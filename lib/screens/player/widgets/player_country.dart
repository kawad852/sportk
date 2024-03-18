import 'package:flutter/material.dart';
import 'package:sportk/model/country_info_model.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class PlayerCountry extends StatelessWidget {
  final CountryInfoModel country;
  const PlayerCountry({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      margin: const EdgeInsetsDirectional.only(end: 15, top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: context.colorPalette.grey3F3,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            context.appLocalization.playerNationality,
            style: TextStyle(
              color: context.colorPalette.blueD4B,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Row(
            children: [
              CustomNetworkImage(
                country.data!.imagePath!,
                width: 20,
                height: 20,
                shape: BoxShape.circle,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 150,
                child: Text(
                  country.data!.name!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.colorPalette.blueD4B,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
