import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class GithubIssues extends StatefulWidget {
  const GithubIssues({super.key});

  @override
  State<GithubIssues> createState() => _GithubIssuesState();
}

class _GithubIssuesState extends State<GithubIssues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050505),
      body: SuperScaffold(
        onCollapsed: (val) {
          print("collapsed => $val");
        },
        stretch: true,
        appBar: SuperAppBar(
          backgroundColor: const Color(0xff17161b),
          automaticallyImplyLeading: true,
          title: Text(
            "Issues",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          previousPageTitle: "Home",
          bottom: SuperAppBarBottom(
            enabled: true,
            height: 40,
            child: const GithubIssuesHeader(),
          ),
          searchBar: SuperSearchBar(
            // height: 190,
            enabled: true,
            scrollBehavior: SearchBarScrollBehavior.pinned,
            resultBehavior: SearchBarResultBehavior.neverVisible,
          ),
          largeTitle: SuperLargeTitle(
            height: 50,
            enabled: true,
            largeTitle: "Issues",
          ),
        ),
        body: ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (c, i) => Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.check_mark_circled,
                  color: CupertinoColors.systemIndigo,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                          opacity: 0.5,
                          child: Text("kspo/super_cupertino_navigation_bar")),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Placeholder text offset when scaling up system accessibility text size"),
                      SizedBox(
                        height: 5,
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          "@kspo, actually, if you have no urgency with your project,",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          separatorBuilder: (c, i) => const Divider(),
          itemCount: 15,
        ),
      ),
    );
  }
}

@immutable
class GithubIssuesHeader extends StatelessWidget {
  const GithubIssuesHeader({super.key});

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
