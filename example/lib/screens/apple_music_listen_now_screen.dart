import 'package:example/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class AppleMusicListenNowScreen extends StatefulWidget {
  const AppleMusicListenNowScreen({super.key});

  @override
  State<AppleMusicListenNowScreen> createState() =>
      _AppleMusicListenNowScreenState();
}

class _AppleMusicListenNowScreenState extends State<AppleMusicListenNowScreen> {
  final _general = General.instance;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SuperCupertinoNavigationBar(
        largeTitle: const Text("Listen Now"),
        largeTitleType: AppBarType.LargeTitleWithoutSearch,
        automaticallyImplyLeading: false,
        stretch: true,
        avatarModel: AvatarModel(
          avatarIsVisible: true,
          onTap: () => _general.showSnackBar(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10.0, bottom: 15),
              child: Row(
                children: [
                  Text(
                    "Starter Shortcuts",
                    style: _general.getSubtitle(context),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.8,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _general.colors.length,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          stops: const [0, 0.7],
                          colors: [
                            Colors.green[500]!,
                            _general.colors[index % _general.colors.length],
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(right: 15),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15),
                                  ),
                                  child: Image.asset(
                                    "assets/apple_music_${6 - (index % 7)}.jpeg",
                                    height: MediaQuery.of(context).size.height /
                                            1.8 -
                                        95,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Image.asset(
                                    "assets/apple_music_logo.png",
                                    height: 17,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const SizedBox(
                              height: 95,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Just Square",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    "3 Grammy Award-winning British and Albanian singer-songwriter. ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    );
                  }),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 35.0, bottom: 15),
              child: Row(
                children: [
                  Text(
                    "Recently Played",
                    style: _general.getSubtitle(context),
                  ),
                  const Icon(
                    CupertinoIcons.chevron_forward,
                    color: CupertinoColors.systemGrey,
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3.4,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _general.colors.length,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          stops: const [0, 0.7],
                          colors: [
                            Colors.green[500]!,
                            _general.colors[index % _general.colors.length],
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(right: 15),
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15),
                                  ),
                                  child: Image.asset(
                                    "assets/apple_music_${(index % 7)}.jpeg",
                                    height:
                                        MediaQuery.of(context).size.height / 3 -
                                            95,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Image.asset(
                                    "assets/apple_music_logo.png",
                                    height: 17,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Camila Cabello",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    "3 Grammy",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
