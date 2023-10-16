import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../general.dart';
import '../models/user_list.model.dart';

enum Options { music, archive }

class AppleMusicScreen extends StatefulWidget {
  const AppleMusicScreen({super.key});

  @override
  State<AppleMusicScreen> createState() => _AppleMusicScreenState();
}

class _AppleMusicScreenState extends State<AppleMusicScreen> {
  Options _selectedSegment = Options.music;
  List<Widget> _results = [], _oldResult = [];
  List<Users> _users = [];
  bool onSubmitted = false;

  Future<List<Users>> search(String text) async {
    try {
      var client = http.Client();

      final response = await client
          .get(Uri.parse('https://dummyjson.com/users/search?q=$text'));

      // print(UserList.fromJson(json.decode(response.body)).users!);
      if (response.statusCode == 200) {
        return UserList.fromJson(json.decode(response.body)).users!;
      } else {
        throw Exception('Something Goes Wrong');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Widget createResultList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 55,
            width: 55,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                _users[index].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${_users[index].firstName} ${_users[index].lastName}"),
                const SizedBox(
                  height: 5,
                ),
                const Opacity(
                  opacity: 0.5,
                  child: Text(
                    "Artist",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.chevron_forward,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      separatorBuilder: (c, i) => Divider(
        color: Colors.grey.withOpacity(0.25),
      ),
      itemCount: _users.length,
    );
  }

  Widget createSuggestionList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            color: CupertinoColors.systemPink,
          ),
          const SizedBox(
            width: 15,
          ),
          Text("${_users[index].firstName} ${_users[index].lastName}")
        ],
      ),
      separatorBuilder: (c, i) => Divider(
        color: Colors.grey.withOpacity(0.25),
        height: 20,
      ),
      itemCount: _users.length > 3 ? 3 : _users.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final general = General.instance;
    return CupertinoPageScaffold(
      child: SuperCupertinoNavigationBar(
        automaticallyImplyLeading: false,
        largeTitle: const Text("Search"),
        largeTitleType: AppBarType.LargeTitleWithPinnedSearch,
        previousPageTitle: "Widgets",
        stretch: true,
        avatarModel: AvatarModel(
          avatarIsVisible: true,
          onTap: null,
          avatarIconColor: CupertinoColors.systemPink,
          icon: CupertinoIcons.profile_circled,
        ),
        searchFieldDecoration: SearchFieldDecoration(
          placeholderText: "Artists, Songs, Lyrics and More",
          cursorColor: CupertinoColors.systemPink,
          cancelButtonStyle: const TextStyle(
            color: CupertinoColors.systemPink,
          ),
          searchFieldBehaviour:
              SearchFieldBehaviour.ShowResultScreenAfterFieldFocused,
          onCancelTap: () => setState(() {
            _users = [];
            onSubmitted = false;
          }),
          onSuffixTap: () => setState(() {
            _users = [];
            onSubmitted = false;
          }),
          onFocused: (focused) {
            if (focused) onSubmitted = false;
            print(focused);
          },
          onChanged: (text) {
            search(text).then((value) {
              _users = value;
              onSubmitted = false;
              setState(() {});
            });
          },
          onSubmitted: (text) {
            search(text).then((value) {
              _users = value;
              onSubmitted = true;
              setState(() {});
            });
          },
          searchResultChildren: _selectedSegment == Options.music
              ? [
                  const SizedBox(
                    height: 5,
                  ),
                  !onSubmitted ? createSuggestionList() : const SizedBox(),
                  _users.isNotEmpty
                      ? Divider(
                          indent: 15,
                          endIndent: 15,
                          color: Colors.grey.withOpacity(0.25),
                          height: 20,
                        )
                      : const SizedBox(),
                  createResultList(),
                ]
              : [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text("this is archive section"),
                  )
                ],
          searchResultHeader: SearchResultHeader(
            height: 50,
            child: Stack(
              children: [
                AnimatedContainer(
                  transform:
                      Matrix4.translationValues(0, !onSubmitted ? 9 : -100, 0),
                  duration: const Duration(milliseconds: 400),
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: AnimatedOpacity(
                    opacity: !onSubmitted ? 1 : 0,
                    duration: const Duration(milliseconds: 400),
                    child: _headerResult(),
                  ),
                ),
                AnimatedContainer(
                  transform:
                      Matrix4.translationValues(0, onSubmitted ? 2 : -100, 0),
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    opacity: onSubmitted ? 1 : 0,
                    duration: const Duration(milliseconds: 400),
                    child: _headerOnSubmitResult(),
                  ),
                ),
              ],
            ),
          ),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10.0, bottom: 15),
              child: Text(
                "Browse Categories",
                style: general.getSubtitle(context),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.3,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/apple_music_${index % 6}.jpeg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Apple Music",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _headerResult() {
    return CupertinoSlidingSegmentedControl<Options>(
      backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
      thumbColor: CupertinoColors.systemGrey2,
      // This represents the currently selected segmented control.
      groupValue: _selectedSegment,

      // Callback that sets the selected segmented control.
      onValueChanged: (Options? value) {
        _oldResult = _results;
        if (value != null) {
          setState(() {
            _selectedSegment = value;
          });
        }
      },
      children: const <Options, Widget>{
        Options.music: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Apple Music',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
        Options.archive: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Archive',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
      },
    );
  }
}

class _headerOnSubmitResult extends StatelessWidget {
  List<String> items = [
    "Best Matches",
    "Artists",
    "Albums",
    "Songs",
    "Lists",
    "Podcasts",
    "Stations",
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? CupertinoColors.systemPink
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Center(
              child: Text(
                items[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
