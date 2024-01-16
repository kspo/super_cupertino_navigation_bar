import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class AppleItunes extends StatefulWidget {
  const AppleItunes({super.key});

  @override
  State<AppleItunes> createState() => _AppleItunesState();
}

class _AppleItunesState extends State<AppleItunes> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      tabBar: CupertinoTabBar(
        activeColor: CupertinoColors.systemOrange,
        backgroundColor: Colors.black.withOpacity(0.95),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.music_note_2), label: "Music"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.film_fill), label: "Movies"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bell_fill), label: "Ring Tones"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.ellipsis), label: "More")
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return Material(
          color: Colors.transparent,
          child: SuperScaffold(
            onCollapsed: (val) {
              print("collapsed => $val");
            },
            stretch: true,
            appBar: SuperAppBar(
              title: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: CupertinoColors.darkBackgroundGray,
                thumbColor: CupertinoColors.systemGrey,
                // This represents the currently selected segmented control.
                groupValue: 1,
                // Callback that sets the selected segmented control.
                onValueChanged: print,
                children: const <int, Widget>{
                  1: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Featured',
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  ),
                  2: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Charts',
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  ),
                },
              ),
              backgroundColor: Colors.black,
              automaticallyImplyLeading: true,
              actions: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.list_bullet,
                    color: CupertinoColors.systemBlue,
                    size: 27,
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              leading: GestureDetector(
                onTap: null,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
                  child: Text(
                    "Genres",
                    style: TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                ),
              ),
              searchBar: SuperSearchBar(
                enabled: false,
              ),
              largeTitle: SuperLargeTitle(
                enabled: false,
              ),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              separatorBuilder: (context, index) => Divider(
                color: CupertinoColors.systemGrey.withOpacity(0.35),
                height: 25,
              ),
              shrinkWrap: true,
              itemCount: 25,
              itemBuilder: (context, index) {
                return Text("Some List $index");
              },
            ),
          ),
        );
      },
    );
  }
}

@immutable
class AppleItunesHeader extends StatelessWidget {
  const AppleItunesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 7.0, vertical: 1.5),
              decoration: BoxDecoration(
                  color: const Color(0xff2f2f37),
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: Colors.white12,
                    width: 1,
                  )),
              child: const Row(
                children: [
                  Icon(Icons.filter_list),
                  Badge(
                    label: Text(
                      "1",
                      style: TextStyle(
                        color: CupertinoColors.systemBlue,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 7.0,
                right: 1,
                top: 1,
                bottom: 1,
              ),
              decoration: BoxDecoration(
                  color: const Color(0xff2f2f37),
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: Colors.white12,
                    width: 1,
                  )),
              child: const Row(
                children: [
                  Text("Open"),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white12,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 7.0,
                right: 1,
                top: 1,
                bottom: 1,
              ),
              decoration: BoxDecoration(
                  color: const Color(0xff2f2f37),
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: Colors.white12,
                    width: 1,
                  )),
              child: const Row(
                children: [
                  Text("Created"),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white12,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 7.0,
                right: 1,
                top: 1,
                bottom: 1,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff2f2f37),
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  color: Colors.white12,
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  Text("Visibility"),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white12,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 7.0,
                right: 1,
                top: 1,
                bottom: 1,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff2f2f37),
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  color: Colors.white12,
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  Text("Organization"),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white12,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 7.0,
                right: 1,
                top: 1,
                bottom: 1,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff2f2f37),
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                  color: Colors.white12,
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  Text("Repository"),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
