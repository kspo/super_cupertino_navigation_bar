import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class LargeTitleSearchScreen extends StatefulWidget {
  const LargeTitleSearchScreen({super.key});

  @override
  State<LargeTitleSearchScreen> createState() => _LargeTitleSearchScreenState();
}

class _LargeTitleSearchScreenState extends State<LargeTitleSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SuperCupertinoNavigationBar(
        largeTitle: const Text("Gallery"),
        appBarType: AppBarType.LargeTitleWithPinnedSearch,
        previousPageTitle: "Widgets",
        stretch: true,
        slivers: [
          SliverToBoxAdapter(
            child: ListView.separated(
              padding: const EdgeInsets.all(15),
              separatorBuilder: (context, index) => const Divider(
                color: CupertinoColors.darkBackgroundGray,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 100,
              itemBuilder: (context, index) {
                return const Row(
                  children: [
                    Icon(Icons.star_border),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Just Text Nothing More"),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
