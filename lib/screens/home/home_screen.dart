import 'package:flutter/material.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/utils/my_icons.dart';
import 'package:sportk/widgets/custom_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              onPressed: () {},
              icon: const CustomSvg(MyIcons.menu),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const CustomSvg(MyIcons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const CustomSvg(MyIcons.calender),
              ),
              Switch(
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Tuesday 12-12-2024",
                style: context.textTheme.labelMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
