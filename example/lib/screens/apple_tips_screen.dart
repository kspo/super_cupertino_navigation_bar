import 'package:example/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class AppleTipsScreen extends StatefulWidget {
  const AppleTipsScreen({super.key});

  @override
  State<AppleTipsScreen> createState() => _AppleTipsScreenState();
}

class _AppleTipsScreenState extends State<AppleTipsScreen> {
  final _general = General.instance;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SuperCupertinoNavigationBar(
        largeTitle: const Text("Tips"),
        automaticallyImplyLeading: false,
        appBarType: AppBarType.LargeTitleWithPinnedSearch,
        searchFieldDecoration: SearchFieldDecoration(
          searchFieldBehaviour:
              SearchFieldBehaviour.ShowResultScreenAfterFieldInput,
        ),
        stretch: true,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: CupertinoTheme.of(context).barBackgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 200,
              child: Stack(
                children: [
                  const Text(
                    "Photos",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  Lottie.asset('assets/favorite.json',
                      height: 225, width: MediaQuery.of(context).size.width),
                ],
              ),
            ),
          ),
          SliverList.builder(
            itemBuilder: (c, i) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 15),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Placeholder",
                        style: _general.getSubtitle(context),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).barBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Divider(
                            color: CupertinoColors.systemGrey.withOpacity(0.35),
                            height: 15,
                            indent: 45,
                          ),
                      padding: const EdgeInsets.all(15),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (Rect bounds) =>
                                  const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomLeft,
                                stops: [0, 1],
                                colors: [
                                  Colors.yellow,
                                  Colors.green,
                                ],
                              ).createShader(bounds),
                              child: const Icon(
                                CupertinoIcons.rectangle_stack_badge_minus,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              "Camera",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            const Icon(
                              CupertinoIcons.chevron_forward,
                              color: CupertinoColors.systemGrey,
                              size: 30,
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
            itemCount: 15,
          ),
        ],
      ),
    );
  }
}
