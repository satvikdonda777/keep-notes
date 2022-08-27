// ignore_for_file: lines_longer_than_80_chars, always_put_required_named_parameters_first, must_be_immutable, public_member_api_docs

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/labelprovider.dart';
import 'package:provider_app/utilities/utilities.dart';

class LabelRowWidget extends StatefulWidget {
  LabelRowWidget({
    required this.data,
    required this.index,
    Key? key,
    required this.onlabelClick,
    required this.oneditClick,
    required this.onTextClick,
    required this.onrowClick,
  }) : super(key: key);
  LabelListTile data;
  int index;
  final VoidCallback onlabelClick;
  final VoidCallback oneditClick;
  final VoidCallback onTextClick;
  final VoidCallback onrowClick;
  @override
  State<LabelRowWidget> createState() => _LabelRowWidgetState();
}

class _LabelRowWidgetState extends State<LabelRowWidget> {
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<LabelProvider>(builder: (context, provider, child) {
      return provider.labelRow.isEmpty
          ? Container()
          : Column(
              children: [
                provider.selectedIndex != widget.index
                    ? Container()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: Colors.grey,
                      ),
                GestureDetector(
                  onTap: widget.onrowClick,
                  child: Row(
                    children: [
                      provider.selectedIndex != widget.index
                          ? IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.label,
                                color: VariableUtilities.theme.keeptextColor,
                              ))
                          : IconButton(
                              onPressed: () {
                                provider.onlabelSelected();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        backgroundColor: VariableUtilities
                                            .theme.backgroundColor,
                                        title: Text(
                                          'Delete label?',
                                          style: FontUtilities.h24(
                                              fontColor: VariableUtilities
                                                  .theme.keeptextColor),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "We'll delete this label and remove if from all of your keep notes.Your notes won't be deleted.",
                                              style: FontUtilities.h16(
                                                  fontColor: VariableUtilities
                                                      .theme.keeptextColor),
                                            )
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                provider.ondeleteButton(
                                                    widget.index);
                                              },
                                              child: const Text('Delete')),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: VariableUtilities.theme.drawerColor,
                              )),
                      provider.selectedIndex != widget.index
                          ? GestureDetector(
                              onTap: widget.onTextClick,
                              child: Container(
                                width: 255,
                                height: 26,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    provider.textController[widget.index + 1],
                                    style: FontUtilities.h18(
                                        fontColor: VariableUtilities
                                            .theme.drawerColor),
                                  ),
                                ),
                              ))
                          : Expanded(
                              child: Form(
                                key: formGlobalKey,
                                child: TextFormField(
                                  autofocus: true,
                                  initialValue:
                                      provider.textController[widget.index + 1],
                                  style: FontUtilities.h18(
                                      fontColor:
                                          VariableUtilities.theme.drawerColor),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: FontUtilities.h16(
                                          fontColor: VariableUtilities
                                              .theme.drawerColor)),
                                  onChanged: (value) {
                                    provider.updateinitialvalue(
                                        value, widget.index);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter valid value';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                      provider.selectedIndex != widget.index
                          ? const Spacer()
                          : Container(),
                      provider.selectedIndex != widget.index
                          ? IconButton(
                              onPressed: widget.onTextClick,
                              icon: Icon(
                                Icons.edit,
                                color: VariableUtilities.theme.drawerColor,
                              ))
                          : IconButton(
                              onPressed: () {
                                if (formGlobalKey.currentState!.validate()) {
                                  provider.onlabelSelected();
                                }
                              },
                              icon: Icon(
                                Icons.check,
                                color: VariableUtilities.theme.drawerColor,
                              )),
                    ],
                  ),
                ),
                provider.selectedIndex != widget.index
                    ? Container()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: Colors.grey,
                      ),
              ],
            );
    });
  }
}
