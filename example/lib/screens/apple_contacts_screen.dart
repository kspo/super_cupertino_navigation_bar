import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../general.dart';
import '../models/user_list.model.dart';

class AppleContactsScreen extends StatefulWidget {
  const AppleContactsScreen({super.key});

  @override
  State<AppleContactsScreen> createState() => _AppleContactsScreenState();
}

class _AppleContactsScreenState extends State<AppleContactsScreen> {
  ScrollController scrollController = ScrollController();
  final alphabets =
      List.generate(26, (index) => String.fromCharCode(index + 65));

  List<Users> _users = [];
  bool focused = false;

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
      itemBuilder: (context, index) =>
          Text("${_users[index].firstName} ${_users[index].lastName}"),
      separatorBuilder: (context, index) => Divider(
        color: CupertinoColors.systemGrey.withOpacity(0.35),
        height: 25,
      ),
      itemCount: _users.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final general = General.instance;
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          SuperCupertinoNavigationBar(
            scrollController: scrollController,
            largeTitle: const Text("Contacts"),
            appBarType: AppBarType.LargeTitleWithPinnedSearch,
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.add)],
            ),
            searchFieldDecoration: SearchFieldDecoration(
              placeholderText: "Search",
              searchFieldBehaviour:
                  SearchFieldBehaviour.ShowResultScreenAfterFieldInput,
              onFocused: (value) => setState(() {
                focused = value;
              }),
              onCancelTap: () => setState(() {
                _users = [];
              }),
              onSuffixTap: () => setState(() {
                _users = [];
              }),
              onChanged: (text) {
                search(text).then((value) {
                  _users = value;
                  setState(() {});
                });
              },
              onSubmitted: (text) {
                search(text).then((value) {
                  _users = value;
                  setState(() {});
                });
              },
              searchResultChildren: [
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(),
                Divider(
                  indent: 15,
                  endIndent: 15,
                  color: Colors.grey.withOpacity(0.25),
                  height: 20,
                ),
                createResultList(),
              ],
            ),
            previousPageTitle: "Lists",
            stretch: true,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 65,
                        width: 65,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(89),
                          child: Image.asset(
                            "assets/profile.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Will Smith",
                            style: general.getSubtitle(context),
                          ),
                          const Opacity(
                            opacity: 0.5,
                            child: Text(
                              "My Card",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: FutureBuilder(
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Users>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 25),
                        separatorBuilder: (context, index) => Divider(
                          color: CupertinoColors.systemGrey.withOpacity(0.35),
                          height: 25,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Text(
                              "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}");
                        },
                      );
                    } else {
                      return const CupertinoActivityIndicator(
                        radius: 13,
                      );
                    }
                  },
                  future: general.getUsers(),
                ),
              ),
            ],
          ),
          focused
              ? const SizedBox()
              : Container(
                  alignment: const Alignment(1, 0),
                  padding: const EdgeInsets.only(right: 2, top: 100),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: alphabets
                        .map((alphabet) => GestureDetector(
                              onTap: () {
                                general.showSnackBar(context);
                              },
                              child: Text(
                                alphabet,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: CupertinoColors.systemBlue),
                              ),
                            ))
                        .toList(),
                  ),
                )
        ],
      ),
    );
  }
}
