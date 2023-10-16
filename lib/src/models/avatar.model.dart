import 'package:flutter/cupertino.dart';

class AvatarModel {
  AvatarModel({
    this.avatarUrl,
    this.avatarIsVisible = false,
    this.onTap,
    this.avatarIconColor = CupertinoColors.link,
    this.icon = CupertinoIcons.profile_circled,
  });
  final String? avatarUrl;
  final bool avatarIsVisible;
  final VoidCallback? onTap;
  final Color avatarIconColor;
  final IconData icon;
}
