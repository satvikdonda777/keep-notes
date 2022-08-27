// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/utilities/utilities.dart';

class RowWidget extends StatelessWidget {
  RowWidget({
    required this.data,
    required this.onCheckBoxStateChange,
    required this.onDelete,
    Key? key,
  }) : super(key: key);
  ListTileData data;
  final Function(bool) onCheckBoxStateChange;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        Icon(
          data.isSelected ? null : Icons.window_rounded,
          color: VariableUtilities.theme.keeptextColor,
        ),
        Checkbox(
            side: BorderSide(
                width: 2, color: VariableUtilities.theme.keeptextColor),
            activeColor: VariableUtilities.theme.searchColor,
            onChanged: (value) {
              onCheckBoxStateChange(value ?? false);
            },
            checkColor: VariableUtilities.theme.backgroundColor,
            value: data.isSelected),
        Expanded(
            child: TextFormField(
          style: FontUtilities.h18(
              fontWeight: FWT.regular,
              fontColor: VariableUtilities.theme.keeptextColor),
          cursorColor: VariableUtilities.theme.keeptextColor,
          cursorHeight: 20,
      
          controller: data.textEditingController,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        )),
        IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.close,
              color: VariableUtilities.theme.keeptextColor,
            ))
      ],
    );
  }
}
