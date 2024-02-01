import 'package:flutter/material.dart';
import 'package:sportk/model/country_model.dart';
import 'package:sportk/providers/football_provider.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';

class PlayerCountry extends StatefulWidget {
  const PlayerCountry({super.key, required this.countryId});
  final String countryId;

  @override
  State<PlayerCountry> createState() => _PlayerCountryState();
}

class _PlayerCountryState extends State<PlayerCountry> {
  late FootBallProvider _footBallProvider;
  late Future<CyModel> _countryFuture;

  void _initializeFuture() {
    _countryFuture = _footBallProvider.fetchCountry();
  }

  @override
  void initState() {
    super.initState();
    _footBallProvider = context.footBallProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _countryFuture,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () {
        return context.loaders.circular(isSmall: true);
      },
      onComplete: ((context, snapshot) {
        String logoCountry = "";
        snapshot.data!.results!.map((data) {
          if (data.id == widget.countryId) {
            logoCountry = data.logo!;
          }
        }).toSet();

        return Stack(
          children: [
            CustomNetworkImage(
              logoCountry,
              width: 30,
              height: 30,
              radius: 0,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 25, start: 5),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: context.colorPalette.white,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "9",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.colorPalette.blueD4B,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
