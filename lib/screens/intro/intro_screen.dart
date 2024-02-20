import 'package:flutter/material.dart';
import 'package:sportk/model/intro_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/screens/wizard/follow_teams_screen.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_smoth_indicator.dart';
import 'package:sportk/widgets/title/medium_title.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentIndex = 0;
  late Future<IntroModel> _introFuture;

  Future<IntroModel> fetchIntro() {
    final snapshot = ApiService<IntroModel>().build(
      weCanUrl: ApiUrl.intro,
      isPublic: true,
      apiType: ApiType.get,
      builder: IntroModel.fromJson,
    );
    return snapshot;
  }

  void _initializeFuture() {
    _introFuture = fetchIntro();
  }

  @override
  void initState() {
    super.initState();
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: context.colorScheme.background,
            textStyle: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
      child: CustomFutureBuilder(
        future: _introFuture,
        onRetry: () {
          setState(() {
            _initializeFuture();
          });
        },
        onComplete: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            extendBody: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: Text(context.appLocalization.skip),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight + 20),
                child: Center(
                  child: Image.asset(MyImages.logo),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomSmoothIndicator(
                  count: snapshot.data!.data!.length,
                  index: _currentIndex,
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    context.push(const FollowTeamsScreen());
                  },
                  child: Text(context.appLocalization.next),
                ),
              ],
            ),
            body: PageView.builder(
              itemCount: snapshot.data!.data!.length,
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              itemBuilder: (context, index) {
                final intro = snapshot.data!.data![index];
                return CustomNetworkImage(
                  '${ApiUrl.weCanMailUrl}/${intro.image}',
                  alignment: AlignmentDirectional.centerStart,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    context.colorScheme.primary,
                                    context.colorPalette.greyD9D.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    context.colorPalette.greyD9D.withOpacity(0.0),
                                    context.colorScheme.primary,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30).copyWith(bottom: 200),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MediumTitle(
                              intro.title!,
                              color: context.colorScheme.background,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              intro.description!,
                              style: TextStyle(
                                color: context.colorScheme.background,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
