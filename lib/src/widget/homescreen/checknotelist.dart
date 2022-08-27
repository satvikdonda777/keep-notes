// ignore_for_file: public_member_api_docs, always_put_required_named_parameters_first, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/model/categorymodel/categorymodel.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';
import 'package:provider_app/src/mvp/users/view/checknotes.dart';
import 'package:provider_app/src/widget/dialog/recorderdialog/recorderdialog.dart';
import 'package:provider_app/utilities/utilities.dart';

// bool isEditMode = false;

class CheckNotesList extends StatefulWidget {
  const CheckNotesList({
    Key? key,
    required this.model,
    required this.provider,
    this.index,
  }) : super(key: key);
  final CategoryModel model;
  final CategoryProvider provider;
  final int? index;

  @override
  State<CheckNotesList> createState() => _CheckNotesListState();
}

class _CheckNotesListState extends State<CheckNotesList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddScreenProvider>(builder: (context, provider, child) {
      return widget.model.titel!.isNotEmpty ||
              widget.model.rawList!.isNotEmpty ||
              widget.model.selectedTile != null ||
              widget.model.selectedTile != 4
          ? GestureDetector(
              onLongPress: () {
                Provider.of<UserProvider>(context, listen: false).onLongPress();
                widget.provider.setSelectionMode(true, widget.index);
                widget.provider.setCategorySelectedIndex(widget.index);
              },
              onTap: widget.provider.isSelectionModeOn
                  ? () {
                      widget.provider.setCategorySelectedIndex(widget.index);
                      widget.provider.truevalue(widget.index, context);
                    }
                  : () {
                      widget.provider.setCategorySelectedIndex(widget.index);
                      widget.provider.setdata(widget.index);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddNotesScreen(
                          index: widget.index,
                          categoryModel: Provider.of<CategoryProvider>(context,
                                          listen: false)
                                      .categorySelectedIndex ==
                                  null
                              ? null
                              : widget.model,
                          isEditMode: Provider.of<CategoryProvider>(context,
                                          listen: false)
                                      .categorySelectedIndex ==
                                  null
                              ? false
                              : true,
                        );
                      }));
                      // Navigator.pushNamed(
                      //     context, RouteUtilities.addnotesScreen);
                    },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: widget.model.backgroundImage == null
                      ? widget.model.color
                      : null,
                  image: widget.model.backgroundImage == null
                      ? null
                      : DecorationImage(
                          image: AssetImage(widget.model.backgroundImage!),
                          fit: BoxFit.fill,
                        ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: widget.model.isSelected!
                          ? Colors.indigo
                          : Colors.grey,
                      width: 2.4),
                ),
                child: Consumer<AddScreenProvider>(
                    builder: (context, provider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.model.imageList!.isNotEmpty
                          ? Consumer<CategoryProvider>(
                              builder: (context, provider, child) {
                              return ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(14),
                                  ),
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget.model.imageList!.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                widget.model.crossCount!,
                                            crossAxisSpacing: 2,
                                            mainAxisSpacing: 2,
                                            childAspectRatio: 1),
                                    itemBuilder: (context, index) {
                                      return Consumer<CategoryProvider>(
                                          builder: (context, provider, child) {
                                        return Image.file(
                                          widget.model.imageList![index],
                                          fit: BoxFit.cover,
                                        );
                                      });
                                    },
                                  ));
                            })
                          : const SizedBox.shrink(),
                      widget.model.titel!.isEmpty
                          ? const SizedBox.shrink()
                          : Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 12),
                              child: Text(
                                widget.model.titel!,
                                style: FontUtilities.h22(
                                    fontColor:
                                        VariableUtilities.theme.keeptextColor),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.model.checkScreen!
                          ? widget.model.notesController!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    widget.model.notesController!,
                                    style: FontUtilities.h16(
                                        fontColor: VariableUtilities
                                            .theme.keeptextColor),
                                  ),
                                )
                              : const SizedBox.shrink()
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.model.rawList!.length <= 10
                                  ? widget.model.rawList!.length
                                  : 10,
                              itemBuilder: ((context, index) {
                                return Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.check_box_outline_blank,
                                      color:
                                          VariableUtilities.theme.keeptextColor,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.model.rawList![index]
                                          .textEditingController.text,
                                      style: FontUtilities.h16(
                                          fontColor: VariableUtilities
                                              .theme.keeptextColor),
                                    ),
                                  ],
                                );
                              }),
                            ),
                      widget.model.checkScreen == false
                          ? widget.model.rawList!.length >= 10
                              ? const Padding(
                                  padding: EdgeInsets.only(left: 12.0, top: 10),
                                  child: Text('---'),
                                )
                              : const SizedBox.shrink()
                          : const SizedBox.shrink(),
                      widget.model.path != null
                          ? const SizedBox(
                              height: 15,
                            )
                          : const SizedBox.shrink(),
                      widget.model.path != null
                          ? Container(
                              height: 35,
                              margin:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: VariableUtilities.theme.keeptextColor
                                      .withOpacity(0.3)),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.play_circle_fill_rounded,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(formatTime(widget.model.duration!)),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      widget.model.selectedTile != null ||
                              widget.model.selectedTile == 4
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 20),
                              child: Container(
                                height: 35,
                                width: widget.model.reminderwidth! - 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: widget.model.reminderColor,
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Icon(
                                      widget.model.reminderIcon,
                                      // provider.icon,
                                      size: 19,
                                      color:
                                          VariableUtilities.theme.keeptextColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${widget.model.reminderText!}${widget.model.reminderTimeText}',
                                        // provider.containertext!,
                                        overflow: TextOverflow.ellipsis,
                                        style: FontUtilities.h16(
                                            fontColor: VariableUtilities
                                                .theme.keeptextColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                }),
              ),
            )
          : Container();
    });
  }
}
