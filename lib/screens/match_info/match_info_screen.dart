import 'package:flutter/material.dart';
import 'package:sportk/alerts/feedback/app_feedback.dart';
import 'package:sportk/model/match_points_model.dart';
import 'package:sportk/model/tracker_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/providers/common_provider.dart';
import 'package:sportk/screens/champions_league/widgets/champions_matches.dart';
import 'package:sportk/screens/chat/chat_screen.dart';
import 'package:sportk/screens/match_info/predictions/predictions_screen.dart';
import 'package:sportk/screens/match_info/widgets/head_to_head.dart';
import 'package:sportk/screens/match_info/widgets/live_tracking.dart';
import 'package:sportk/screens/match_info/widgets/match_card.dart';
import 'package:sportk/screens/match_info/widgets/match_detalis.dart';
import 'package:sportk/screens/match_info/widgets/match_events.dart';
import 'package:sportk/screens/match_info/widgets/match_info_loading.dart';
import 'package:sportk/screens/match_info/widgets/match_scorers.dart';
import 'package:sportk/screens/match_info/widgets/match_statistics.dart';
import 'package:sportk/screens/match_info/widgets/teams_plan.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/utils/my_images.dart';
import 'package:sportk/utils/my_theme.dart';
import 'package:sportk/utils/shared_pref.dart';
import 'package:sportk/widgets/custom_back.dart';
import 'package:sportk/widgets/custom_future_builder.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/league_standings.dart';
import 'package:sportk/widgets/stretch_button.dart';

class MatchInfoScreen extends StatefulWidget {
  final int matchId;
  final int leagueId;
  final String subType;
  const MatchInfoScreen({
    super.key,
    required this.matchId,
    required this.leagueId,
    required this.subType,
  });

  @override
  State<MatchInfoScreen> createState() => _MatchInfoScreenState();
}

class _MatchInfoScreenState extends State<MatchInfoScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  late final AppLifecycleListener _listener;
  bool get _isDomestic => widget.subType == LeagueTypeEnum.domestic;
  late int lengthTab;
  String? matchLink;
  bool showTracker = false;
  late CommonProvider _commonProvider;
  late Future<MatchPointsModel> _matchPointsFuture;

  void _initializeFuture() async {
    _matchPointsFuture = _commonProvider.getMatchPoints(widget.matchId);
  }

  void fetchMatchTracker() {
    ApiFutureBuilder<TrackerModel>().fetch(
      context,
      future: () async {
        final trackerFuture = _commonProvider.fetchTracker(widget.matchId);
        return trackerFuture;
      },
      onComplete: (snapshot) {
        final matchTracker = snapshot.data;
        if (matchTracker == null) {
          context.showSnackBar(context.appLocalization.noLiveTracking);
        } else {
          switch ([MySharedPreferences.language, MySharedPreferences.theme]) {
            case [LanguageEnum.english, ThemeEnum.light]:
              matchLink = matchTracker.trackerLinkEn ?? "";
            case [LanguageEnum.english, ThemeEnum.dark]:
              matchLink = matchTracker.darkTrackerLinkEn ?? "";
            case [LanguageEnum.arabic, ThemeEnum.light]:
              matchLink = matchTracker.trackerLinkAr ?? "";
            case [LanguageEnum.arabic, ThemeEnum.dark]:
              matchLink = matchTracker.darkTrackerLinkAr ?? "";
          }
          setState(() {
            _controller?.length = lengthTab + 1;
            showTracker = true;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // log(MySharedPreferences.accessToken);
    _commonProvider = context.commonProvider;
    _initializeFuture();
    _listener = AppLifecycleListener(
      onShow: () {
        setState(() {
          _initializeFuture();
        });
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _matchPointsFuture,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onLoading: () {
        return const MatchInfoLoading();
      },
      onComplete: (context, snapshot) {
        final matchPoints = snapshot.data!;
        final pointsData = matchPoints.data;
        lengthTab = pointsData!.status == 1 ? 8 : 7;
        _controller ??= TabController(length: lengthTab, vsync: this);
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: StretchedButton(
              onPressed: () {
                context.showBottomSheet(
                  context,
                  // maxHeight: context.mediaQuery.height * 0.63,
                  builder: (context) {
                    return ChatScreen(matchId: widget.matchId);
                  },
                );
              },
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(context.appLocalization.chat),
            ),
          ),
          body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                leadingWidth: kBarLeadingWith,
                collapsedHeight: kBarCollapsedHeight,
                centerTitle: true,
                pinned: true,
                leading: Align(
                  alignment: Alignment.topCenter,
                  child: CustomBack(
                    color: context.colorPalette.white,
                  ),
                ),
                //title: LiveBubble(matchId: widget.matchId),
                actions: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      onPressed: () {},
                      icon: const CustomSvg(MyIcons.notification),
                    ),
                  ),
                ],
                flexibleSpace: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        MyTheme.isLightTheme(context)
                            ? MyImages.backgroundClub
                            : MyImages.backgroundClubDark,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    
                    children: [
                      MatchCard(
                        matchId: widget.matchId,
                        statusMatch: pointsData.statusSoon!,
                        firstMatchId: pointsData.goingMatch,
                        onTracking: () {
                          fetchMatchTracker();
                        },
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 20),
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(MyTheme.radiusSecondary),
                            color: context.colorPalette.grey9E9,
                          ),
                          child: TabBar(
                            controller: _controller,
                            dividerColor: Colors.transparent,
                            isScrollable: true,
                            indicatorColor: context.colorPalette.tabColor,
                            labelColor: context.colorPalette.tabColor,
                            tabAlignment: TabAlignment.center,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsetsDirectional.only(
                                bottom: 8, end: 30, top: 10),
                            padding:
                                const EdgeInsetsDirectional.only(start: 10),
                            tabs: [
                              if (showTracker)
                                Text(context.appLocalization.liveTracking),
                              if (pointsData.status == 1)
                                Row(
                                  children: [
                                    const CustomSvg(
                                      MyIcons.coin,
                                      fixedColor: true,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(context.appLocalization.predictAndWin),
                                  ],
                                ),
                              Text(context.appLocalization.matchEvents),
                              Text(context.appLocalization.plan),
                              Text(context.appLocalization.statistics),
                              Text(context.appLocalization.details),
                              Text(
                                _isDomestic
                                    ? context.appLocalization.standings
                                    : context.appLocalization.table,
                              ),
                              Text(context.appLocalization.scorers),
                              Text(context.appLocalization.headTwohead),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  physics:
                      showTracker ? const NeverScrollableScrollPhysics() : null,
                  controller: _controller,
                  children: [
                    if (showTracker) LiveTracking(link: matchLink!),
                    if (pointsData.status == 1)
                      PredictionsScreen(pointsData: pointsData),
                    MatchEvents(
                        matchPoint: matchPoints,
                        matchId: widget.matchId,
                        homeId: int.parse(pointsData.homeId!)),
                    TeamsPlan(matchId: widget.matchId),
                    MatchStatistics(matchId: widget.matchId),
                    MatchDetalis(matchId: widget.matchId),
                    _isDomestic
                        ? LeagueStandings(
                            leagueId: widget.leagueId,
                            selectedTeamId: int.parse(pointsData.homeId!),
                            selectedTeamId2: int.parse(pointsData.awayId!),
                          )
                        : ChampionsMatches(leagueId: widget.leagueId),
                    MatchScorers(leagueId: widget.leagueId),
                    HeadToHead(
                      fisrtTeamId: int.parse(pointsData.homeId!),
                      secondTeamId: int.parse(pointsData.awayId!),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
