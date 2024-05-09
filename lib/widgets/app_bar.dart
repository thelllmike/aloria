import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  const CustomSliverAppBar({
    Key? key,
    this.title = '',
    this.actions,
    this.leading,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      leading: leading ?? IconButton(
        icon: Icon(UniconsLine.paragraph, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Nunito',
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
      actions: actions ?? [
        IconButton(
          icon: const Icon(UniconsLine.comments, color: Colors.black),
          onPressed: () {
            // Implement action
          },
        ),
      ],
      bottom: bottom,
    );
  }
}
