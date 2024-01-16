import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:untitled/utils/general.dart';

class AppleTips extends StatefulWidget {
  const AppleTips({super.key});

  @override
  State<AppleTips> createState() => _AppleTipsState();
}

class _AppleTipsState extends State<AppleTips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SuperScaffold(
        onCollapsed: (val) {
          print("collapsed => $val");
        },
        stretch: true,
        appBar: SuperAppBar(
          backgroundColor: Colors.black.withOpacity(0.5),
          height: 45,
          title: Text(
            "Tips",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          automaticallyImplyLeading: false,
          previousPageTitle: "Home",
          searchBar: SuperSearchBar(
            resultColor: Colors.black.withOpacity(0.95),
            enabled: true,
            scrollBehavior: SearchBarScrollBehavior.pinned,
            resultBehavior: SearchBarResultBehavior.visibleOnInput,
          ),
          largeTitle: SuperLargeTitle(
            enabled: true,
            height: 50,
            largeTitle: "Tips",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 200,
                child: Stack(
                  children: [
                    const Text(
                      "Photos",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    Lottie.asset('assets/favorite.json',
                        height: 225, width: MediaQuery.of(context).size.width),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
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
                            style: General.instance.getSubtitle(context),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: 3,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => Divider(
                                color: CupertinoColors.systemGrey
                                    .withOpacity(0.35),
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
        ),
      ),
    );
  }
}
