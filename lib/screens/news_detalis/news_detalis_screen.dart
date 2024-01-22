import 'package:flutter/material.dart';
import 'package:sportk/utils/app_constants.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/news_detalis_card.dart';
import 'package:sportk/widgets/comment.dart';
import 'package:sportk/widgets/custom_network_image.dart';
import 'package:sportk/widgets/custom_svg.dart';
import 'package:sportk/widgets/latest_news.dart';

class NewsDetalisScreen extends StatefulWidget {
  const NewsDetalisScreen({super.key});

  @override
  State<NewsDetalisScreen> createState() => _NewsDetalisScreenState();
}

class _NewsDetalisScreenState extends State<NewsDetalisScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                leadingWidth: 120,
                pinned: true,
                leading: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                        )),
                    const Text(
                      "رجوع",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                  child: NewsDetalisCard(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 20,
                    start: 20,
                    bottom: 5,
                  ),
                  child: Text(
                    "اضف تعليق",
                    style: TextStyle(
                      color: context.colorPalette.blueD4B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  child: Container(
                    width: 350,
                    height: 105,
                    decoration: BoxDecoration(
                      color: context.colorPalette.grey3F3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const CustomNetworkImage(
                                kFakeImage,
                                radius: 20,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "المهيار زهره",
                                style: TextStyle(
                                  color: context.colorPalette.blueD4B,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    fillColor: context.colorPalette.white,
                                    contentPadding:
                                        const EdgeInsetsDirectional.symmetric(
                                            horizontal: 5, vertical: 15),
                                    hintText: "اكتب تعليقك هنا",
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Container(
                                  width: 45,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: context.colorPalette.blueD4B,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Transform.scale(
                                    scale: 0.7,
                                    child: const CustomSvg(
                                      MyIcons.send,
                                      height: 5,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5,
                    start: 20,
                    bottom: 5,
                  ),
                  child: Text(
                    "جميع التعليقات",
                    style: TextStyle(
                      color: context.colorPalette.blueD4B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsetsDirectional.all(20),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    return const Comment();
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: 2,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5,
                    start: 20,
                    bottom: 5,
                  ),
                  child: Text(
                    "المزيد من الاخبار",
                    style: TextStyle(
                      color: context.colorPalette.blueD4B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsetsDirectional.all(20),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    return const LatestNews();
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemCount: 6,
                ),
              )
            ],
          ),
        ));
  }
}
