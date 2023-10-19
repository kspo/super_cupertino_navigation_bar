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
              onPressed: () => print("object"),
              child: Icon(
                CupertinoIcons.ellipsis_circle,
                color: CupertinoTheme.of(context).primaryColor,
                size: 25,
              ),
            ),
          ],
        ),
        searchFieldDecoration: SearchFieldDecoration(
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
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 15),
              crossAxisCount: 3,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(100, (index) {
                return Column(
                  children: [
                    Icon(
                      CupertinoIcons.folder_solid,
                      size: 90,
                    ),
                    const Text(
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
