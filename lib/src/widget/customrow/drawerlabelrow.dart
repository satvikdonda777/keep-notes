import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/labelprovider.dart';
import 'package:provider_app/utilities/utilities.dart';

class DrawerLabelRow extends StatefulWidget {
  DrawerLabelRow(
      {Key? key,
      required this.onrowClick,
      required this.data,
      required this.index})
      : super(key: key);
  final VoidCallback onrowClick;
  LabelListTile data;
  int index;
  @override
  State<DrawerLabelRow> createState() => _DrawerLabelRowState();
}

class _DrawerLabelRowState extends State<DrawerLabelRow> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LabelProvider>(builder: (context, provider, child) {
      return provider.labelRow.isEmpty
          ? Container()
          : GestureDetector(
              onTap: widget.onrowClick,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.label,
                        color: VariableUtilities.theme.drawerColor,
                      )),
                  GestureDetector(
                      child: Container(
                    width: 200,
                    height: 26,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        provider.textController[widget.index + 1],
                        style: FontUtilities.h18(
                            fontColor: VariableUtilities.theme.drawerColor),
                      ),
                    ),
                  ))
                ],
              ),
            );
    });
  }
}
