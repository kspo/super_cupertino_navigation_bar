import 'package:flutter/cupertino.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class AppleFoldersBrowse extends StatelessWidget {
  const AppleFoldersBrowse({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SuperCupertinoNavigationBar(
        largeTitle: const Text("My iPhone"),
        appBarType: AppBarType.NormalNavbarWithPinnedSearch,
        previousPageTitle: "Browse",
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: null,
              child: Icon(
                CupertinoIcons.ellipsis_circle,
                color: CupertinoTheme.of(context).primaryColor,
                size: 25,
              ),
            ),
          ],
        ),
        searchFieldDecoration: SearchFieldDecoration(
          actionButtons: [
            SearchBarActionButton(
              actionButtonsBehaviour:
                  SearchFieldActionButtonsBehaviour.VisibleOnFocus,
              icon: const Icon(CupertinoIcons.square_grid_2x2),
              onPressed: () => showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) => Container(
                  width: double.infinity,
                  color: CupertinoColors.white,
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/heisenberg.jpeg",
                        width: 250,
                      ),
                      const Text("I'm not in a danger, Skylar!"),
                      const Text(
                        "I'm the danger!",
                        style: TextStyle(
                          color: CupertinoColors.destructiveRed,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          searchFieldBehaviour:
              SearchFieldBehaviour.ShowResultScreenAfterFieldInput,
        ),
        stretch: true,
        slivers: [
          SliverToBoxAdapter(
            child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 15),
              crossAxisCount: 3,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(100, (index) {
                return const Column(
                  children: [
                    Icon(
                      CupertinoIcons.folder_solid,
                      size: 90,
                    ),
                    Text(
                      "Photos",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
