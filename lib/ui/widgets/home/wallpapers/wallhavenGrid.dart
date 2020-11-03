import 'package:Prism/data/wallhaven/provider/wallhavenWithoutProvider.dart'
    as wData;
import 'package:Prism/global/categoryProvider.dart';
import 'package:Prism/routes/routing_constants.dart';
import 'package:Prism/theme/themeModel.dart';
import 'package:Prism/ui/widgets/focussedMenu/focusedMenu.dart';
import 'package:Prism/ui/widgets/home/core/inheritedScrollControllerProvider.dart';
import 'package:Prism/ui/widgets/home/wallpapers/carouselDots.dart';
import 'package:Prism/ui/widgets/home/wallpapers/seeMoreButton.dart';
import 'package:Prism/ui/widgets/home/wallpapers/wallhavenTile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:Prism/global/globals.dart' as globals;

class WallHavenGrid extends StatefulWidget {
  final String provider;
  const WallHavenGrid({@required this.provider});
  @override
  _WallHavenGridState createState() => _WallHavenGridState();
}

class _WallHavenGridState extends State<WallHavenGrid> {
  //   with TickerProviderStateMixin {
  // AnimationController _controller;
  // Animation<Color> animation;
  int _current = 0;
  GlobalKey<RefreshIndicatorState> refreshHomeKey =
      GlobalKey<RefreshIndicatorState>();

  bool seeMoreLoader = false;
  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   duration: const Duration(milliseconds: 800),
    //   vsync: this,
    // );
    // animation = Provider.of<ThemeModel>(context, listen: false)
    //             .returnThemeType() ==
    //         "Dark"
    //     ? TweenSequence<Color>(
    //         [
    //           TweenSequenceItem(
    //             weight: 1.0,
    //             tween: ColorTween(
    //               begin: Colors.white10,
    //               end: const Color(0x22FFFFFF),
    //             ),
    //           ),
    //           TweenSequenceItem(
    //             weight: 1.0,
    //             tween: ColorTween(
    //               begin: const Color(0x22FFFFFF),
    //               end: Colors.white10,
    //             ),
    //           ),
    //         ],
    //       ).animate(_controller)
    //     : TweenSequence<Color>(
    //         [
    //           TweenSequenceItem(
    //             weight: 1.0,
    //             tween: ColorTween(
    //               begin: Colors.black.withOpacity(.1),
    //               end: Colors.black.withOpacity(.14),
    //             ),
    //           ),
    //           TweenSequenceItem(
    //             weight: 1.0,
    //             tween: ColorTween(
    //               begin: Colors.black.withOpacity(.14),
    //               end: Colors.black.withOpacity(.1),
    //             ),
    //           ),
    //         ],
    //       ).animate(_controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });
    // _controller.repeat();
  }

  @override
  void dispose() {
    // _controller?.dispose();
    super.dispose();
  }

  Future<void> refreshList() async {
    refreshHomeKey.currentState?.show();
    await Future.delayed(const Duration(milliseconds: 500));
    wData.walls = [];
    Provider.of<CategorySupplier>(context, listen: false).changeWallpaperFuture(
        Provider.of<CategorySupplier>(context, listen: false).selectedChoice,
        "r");
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController controller =
        InheritedDataProvider.of(context).scrollController;
    final CarouselController carouselController = CarouselController();
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: NestedScrollView(
        controller: controller,
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            primary: false,
            backgroundColor: Theme.of(context).primaryColor,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            expandedHeight: 200,
            flexibleSpace: SizedBox(
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget>[
                  CarouselSlider.builder(
                    carouselController: carouselController,
                    itemCount: 5,
                    options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        onPageChanged: (index, reason) {
                          if (mounted) {
                            setState(() {
                              _current = index;
                            });
                          }
                        }),
                    itemBuilder: (BuildContext context, int i) => i == 4
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.fromLTRB(5, 1, 5, 7),
                            child: GestureDetector(
                              onTap: () {
                                launch("https://twitter.com/PrismWallpapers");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Provider.of<ThemeModel>(context,
                                                    listen: false)
                                                .returnThemeType() ==
                                            "Dark"
                                        ? Colors.white10
                                        : Colors.black.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            "https://unblast.com/wp-content/uploads/2018/08/Gradient-Mesh-21.jpg"),
                                        fit: BoxFit.cover)),
                                child: Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black.withOpacity(0.4),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "FOLLOW US ON TWITTER",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            .copyWith(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.fromLTRB(5, 1, 5, 7),
                            child: GestureDetector(
                              onTap: () {
                                if (wData.walls == []) {
                                } else {
                                  Navigator.pushNamed(context, wallpaperRoute,
                                      arguments: [
                                        widget.provider,
                                        i,
                                        wData.walls[i].thumbs["small"],
                                      ]);
                                }
                              },
                              child: wData.walls.isEmpty
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Provider.of<ThemeModel>(context,
                                                        listen: false)
                                                    .returnThemeType() ==
                                                "Dark"
                                            ? Colors.white10
                                            : Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Provider.of<ThemeModel>(
                                                          context,
                                                          listen: false)
                                                      .returnThemeType() ==
                                                  "Dark"
                                              ? Colors.white10
                                              : Colors.black.withOpacity(.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  wData.walls[i]
                                                      .thumbs["original"]
                                                      .toString()),
                                              fit: BoxFit.cover)),
                                      child: Center(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.black.withOpacity(0.4),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              globals.topTitleText[i]
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                  ),
                  CarouselDots(current: _current),
                ],
              ),
            ),
          ),
        ],
        body: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          key: refreshHomeKey,
          onRefresh: refreshList,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                if (!seeMoreLoader) {
                  Provider.of<CategorySupplier>(context, listen: false)
                      .changeWallpaperFuture(
                          Provider.of<CategorySupplier>(context, listen: false)
                              .selectedChoice,
                          "s");

                  setState(() {
                    seeMoreLoader = true;
                    Future.delayed(const Duration(seconds: 4))
                        .then((value) => seeMoreLoader = false);
                  });
                }
              }
              return false;
            },
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 4),
              itemCount: wData.walls.isEmpty ? 20 : wData.walls.length - 4,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 300
                          : 250,
                  childAspectRatio: 0.6625,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8),
              itemBuilder: (context, index) {
                index = index + 4;
                if (index == wData.walls.length - 1) {
                  return SeeMoreButton(
                    seeMoreLoader: seeMoreLoader,
                    func: () {
                      if (!seeMoreLoader) {
                        Provider.of<CategorySupplier>(context, listen: false)
                            .changeWallpaperFuture(
                                Provider.of<CategorySupplier>(context,
                                        listen: false)
                                    .selectedChoice,
                                "s");

                        setState(
                          () {
                            seeMoreLoader = true;
                            Future.delayed(const Duration(seconds: 4))
                                .then((value) => seeMoreLoader = false);
                          },
                        );
                      }
                    },
                  );
                }
                return FocusedMenuHolder(
                  provider: widget.provider,
                  index: index,
                  // child: AnimatedBuilder(
                  //   animation: offsetAnimation,
                  //   builder: (buildContext, child) {
                  child: WallhavenTile(widget: widget, index: index),
                  //   },
                  // ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
