import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class AppleClock extends StatefulWidget {
  const AppleClock({super.key});

  @override
  State<AppleClock> createState() => _AppleClockState();
}

class _AppleClockState extends State<AppleClock> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      tabBar: CupertinoTabBar(
        activeColor: CupertinoColors.systemOrange,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.placemark), label: "World Wlock"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.alarm_fill), label: "Alarms"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.stopwatch_fill), label: "World Wlock"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.speedometer), label: "Alarms")
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
              title: Text(
                "World Clock",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              backgroundColor: Colors.black,
              height: 45,
              automaticallyImplyLeading: true,
              previousPageTitle: "Home",
              actions: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.add,
                    color: CupertinoColors.systemOrange,
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
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.systemOrange,
                    ),
                  ),
                ),
              ),
              searchBar: SuperSearchBar(
                // height: 190,
                enabled: false,
                scrollBehavior: SearchBarScrollBehavior.pinned,
                resultBehavior: SearchBarResultBehavior.neverVisible,
              ),
              largeTitle: SuperLargeTitle(
                enabled: true,
                height: 50,
                largeTitle: "World Clock",
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
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: Text(
                              "TODAY, +3HRS",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Text(
                            "New York",
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${12 + index}:32",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(fontSize: 45),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "PM",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

@immutable
class AppleClockHeader extends StatelessWidget {
  const AppleClockHeader({super.key});

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
