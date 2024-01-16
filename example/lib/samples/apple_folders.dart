import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class AppleFolders extends StatefulWidget {
  const AppleFolders({super.key});

  @override
  State<AppleFolders> createState() => _AppleFoldersState();
}

class _AppleFoldersState extends State<AppleFolders> {
  bool hasData = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SuperScaffold(
        onCollapsed: (val) {
          print("collapsed => $val");
        },
        stretch: false,
        appBar: SuperAppBar(
            backgroundColor: Colors.black.withOpacity(0.5),
            height: 45,
            automaticallyImplyLeading: true,
            previousPageTitle: "Home",
            title: Text(
              "My iPhone",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            actions: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.ellipsis_circle,
                  color: CupertinoColors.systemBlue,
                  size: 27,
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            searchBar: SuperSearchBar(
              enabled: true,
              onChanged: (c) {
                hasData = c.isNotEmpty;
                setState(() {});
              },
              scrollBehavior: SearchBarScrollBehavior.pinned,
              resultBehavior: SearchBarResultBehavior.neverVisible,
              actions: [
                const SuperAction(
                  behavior: SuperActionBehavior.visibleOnFocus,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 5),
                    child: Icon(CupertinoIcons.square_grid_2x2),
                  ),
                )
              ],
            ),
            largeTitle: SuperLargeTitle(
              enabled: false,
              height: 50,
              largeTitle: "My iPhone",
            ),
            bottom: SuperAppBarBottom(
              enabled: hasData,
              height: 35,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CupertinoSlidingSegmentedControl<String>(
                  backgroundColor:
                      CupertinoTheme.of(context).barBackgroundColor,
                  thumbColor: CupertinoColors.systemGrey2,
                  // This represents the currently selected segmented control.
                  groupValue: "Recently",

                  // Callback that sets the selected segmented control.
                  onValueChanged: (value) {},
                  children: const <String, Widget>{
                    "Recently": Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Recently',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    "My_iPhone": Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'MyiPhone',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                  },
                ),
              ),
            )),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
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
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: CupertinoColors.systemBlue,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.clock_fill), label: "Last"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.folder_fill_badge_person_crop),
              label: "Shared"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.folder_solid), label: "Browse"),
        ],
      ),
    );
  }
}
