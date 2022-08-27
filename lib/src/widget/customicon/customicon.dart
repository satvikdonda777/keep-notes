import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/iconprovider/cusromicon_provider.dart';
import 'package:provider_app/utilities/settings/settings.dart';

class CustomIcon extends StatefulWidget {
  const CustomIcon({Key? key}) : super(key: key);
  @override
  State<CustomIcon> createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomIconProvider>(builder: (context, provider, child) {
      return GestureDetector(
        onTap: () {
          provider.toggleIcon();
        },
        child: Icon(
            provider.isSelected
                ? Icons.view_agenda_outlined
                : Icons.grid_view_outlined,
            color: VariableUtilities.theme.keeptextColor),
      );
    });
  }
}
