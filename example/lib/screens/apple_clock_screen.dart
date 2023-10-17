import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../general.dart';
import '../models/user_list.model.dart';

class AppleClocksScreen extends StatefulWidget {
  const AppleClocksScreen({super.key});

  @override
  State<AppleClocksScreen> createState() => _AppleClocksScreenState();
}

class _AppleClocksScreenState extends State<AppleClocksScreen> {
  final alphabets =
      List.generate(26, (index) => String.fromCharCode(index + 65));

  final List<Users> _users = [];
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
      child: SuperCupertinoNavigationBar(
        largeTitle: const Text("World Clock"),
        appBarType: AppBarType.LargeTitleWithoutSearch,
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(CupertinoIcons.add)],
        ),
        leading: GestureDetector(
          onTap: null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "Edit",
              style: general.getLinkStyle(context).copyWith(fontSize: 18),
            ),
          ),
        ),
        stretch: false,
        slivers: [
          SliverFillRemaining(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              separatorBuilder: (context, index) => Divider(
                color: CupertinoColors.systemGrey.withOpacity(0.35),
                height: 25,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
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
        ],
      ),
    );
  }
}
