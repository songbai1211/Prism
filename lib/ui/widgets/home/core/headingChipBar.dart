import 'package:Prism/routes/router.dart';
import 'package:Prism/theme/jam_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HeadingChipBar extends StatefulWidget {
  final String current;
  const HeadingChipBar({Key key, @required this.current}) : super(key: key);

  @override
  _HeadingChipBarState createState() => _HeadingChipBarState();
}

class _HeadingChipBarState extends State<HeadingChipBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
          icon: const Icon(JamIcons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
            if (navStack.length > 1) {
              navStack.removeLast();
              if ((navStack.last == "Wallpaper") ||
                  (navStack.last == "Search Wallpaper") ||
                  (navStack.last == "SharedWallpaper") ||
                  (navStack.last == "SetupView")) {
                SystemChrome.setEnabledSystemUIOverlays([]);
              }
            }
            debugPrint(navStack.toString());
          }),
      title: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ActionChip(
                  pressElevation: 5,
                  padding: const EdgeInsets.fromLTRB(14, 11, 14, 11),
                  backgroundColor: Theme.of(context).accentColor,
                  label: Text(widget.current,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Theme.of(context).primaryColor)),
                  onPressed: () {}),
            ),
          )),
    );
  }
}
