import 'package:example/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class LargeTitleSearchActionsScreen extends StatefulWidget {
  const LargeTitleSearchActionsScreen({super.key});

  @override
  State<LargeTitleSearchActionsScreen> createState() =>
      _LargeTitleSearchActionsScreenState();
}

class _LargeTitleSearchActionsScreenState
    extends State<LargeTitleSearchActionsScreen> {
  final _general = General.instance;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SuperCupertinoNavigationBar(
        largeTitle: const Text("Share Sheet"),
        previousPageTitle: "Widgets", //avatarUrl: "assets/profile.png",
        avatarModel: AvatarModel(
          avatarIsVisible: true,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _general.showSnackBar(context),
              child: const Text("Edit"),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _general.showSnackBar(context),
              child: Icon(
                CupertinoIcons.square_grid_2x2,
                color: CupertinoTheme.of(context).primaryColor,
                size: 25,
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _general.showSnackBar(context),
              child: Icon(
                CupertinoIcons.add,
                color: CupertinoTheme.of(context).primaryColor,
                size: 25,
              ),
            ),
          ],
        ),
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
