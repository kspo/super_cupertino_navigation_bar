import 'package:example/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class NormalNavbarActionsScreen extends StatelessWidget {
  const NormalNavbarActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final general = General.instance;
    return CupertinoPageScaffold(
      navigationBar: DefaultCupertinoNavigationBar(
        middle: const Text("Steps"),
        previousPageTitle: "Widgets",
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => general.showSnackBar(context),
              child: const Text("Add Data"),
            ),
          ],
        ),
      ),
      child: const Center(
        child: Text("Second Screen"),
      ),
    );
  }
}
