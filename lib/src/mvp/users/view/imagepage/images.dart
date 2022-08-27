import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';
import 'package:provider_app/src/mvp/users/view/brushscreen.dart';
import 'package:provider_app/utilities/font/font_utilities.dart';
import 'package:provider_app/utilities/route/route_utilities.dart';
import 'package:provider_app/utilities/settings/settings.dart';
import 'package:share_plus/share_plus.dart';

class ImagePage extends StatefulWidget {
  int index;
  ImagePage({required this.index, Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.backgroundColor,
      body: SafeArea(
        child: Consumer<AddScreenProvider>(builder: (context, provider, child) {
          return Column(
            children: [
              Container(
                height: 60,
                color: VariableUtilities.theme.searchColor.withOpacity(0.4),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: VariableUtilities.theme.keeptextColor,
                        )),
                    Consumer<AddScreenProvider>(
                        builder: (context, provider, child) {
                      return Text(
                        '${provider.initialIndex + 1} of ${provider.imagelist.length}',
                        style: FontUtilities.h18(
                            fontColor: VariableUtilities.theme.keeptextColor),
                      );
                    }),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BrushScreen(
                              index: widget.index,
                            );
                          }));
                          provider.isbackgroundImage = true;
                        },
                        icon: Icon(
                          Icons.brush_outlined,
                          color: VariableUtilities.theme.keeptextColor,
                        )),
                    PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert_outlined,
                          color: VariableUtilities.theme.keeptextColor,
                        ),
                        color: VariableUtilities.theme.backgroundColor,
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                                value: 1,
                                child: Text(
                                  'Grab image text',
                                  style: FontUtilities.h16(
                                      fontColor: VariableUtilities
                                          .theme.keeptextColor),
                                )),
                            PopupMenuItem(
                                value: 2,
                                child: Text(
                                  'Copy',
                                  style: FontUtilities.h16(
                                      fontColor: VariableUtilities
                                          .theme.keeptextColor),
                                )),
                            PopupMenuItem(
                                value: 3,
                                child: Text(
                                  'Send',
                                  style: FontUtilities.h16(
                                      fontColor: VariableUtilities
                                          .theme.keeptextColor),
                                )),
                            PopupMenuItem(
                                value: 4,
                                child: Text(
                                  'Delete',
                                  style: FontUtilities.h16(
                                      fontColor: VariableUtilities
                                          .theme.keeptextColor),
                                )),
                          ];
                        },
                        onSelected: (value) {
                          switch (value) {
                            case 1:
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Can't grab image text. Try again later")));
                              break;
                            case 2:
                              break;
                            case 3:
                              final box =
                                  context.findRenderObject() as RenderBox?;

                              Share.shareFiles(
                                  [imagePaths[provider.initialIndex]],
                                  text: '',
                                  subject: 'I dont know',
                                  sharePositionOrigin:
                                      box!.localToGlobal(Offset.zero) &
                                          box.size);
                              break;

                            case 4:
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      backgroundColor: VariableUtilities
                                          .theme.backgroundColor,
                                      title: Text(
                                        'Delete image?',
                                        style: FontUtilities.h16(
                                            fontColor: VariableUtilities
                                                .theme.keeptextColor),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel')),
                                        TextButton(
                                            onPressed: () {
                                              provider.removeindexImage(
                                                  widget.index);

                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Delete')),
                                      ],
                                    );
                                  });
                              break;
                          }
                        }),
                  ],
                ),
              ),
              Expanded(
                child: Consumer<AddScreenProvider>(
                    builder: (context, provider, child) {
                  final _controller = PageController(initialPage: widget.index);
                  return Consumer<AddScreenProvider>(
                      builder: (context, provider, child) {
                    return PageView.builder(
                        onPageChanged: (value) {
                          provider.changePage(value);
                        },
                        controller: _controller,
                        itemCount: provider.imagelist.length,
                        itemBuilder: (context, index) {
                          return Consumer<AddScreenProvider>(
                              builder: (context, provider, child) {
                            return InteractiveViewer(
                              child: Container(
                                height: double.maxFinite,
                                width: double.infinity,
                                child: Consumer<AddScreenProvider>(
                                    builder: (context, provider, child) {
                                  return Image.file(provider.imagelist[index]);
                                }),
                              ),
                            );
                          });
                        });
                  });
                }),
              )
            ],
          );
        }),
      ),
    );
  }
}
