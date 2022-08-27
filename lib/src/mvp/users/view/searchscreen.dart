import 'package:flutter/material.dart';
import 'package:provider_app/utilities/font/font_utilities.dart';
import 'package:provider_app/utilities/settings/settings.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.backgroundColor,
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 8),
              height: 100,
              decoration: BoxDecoration(
                  color: VariableUtilities.theme.searchColor.withOpacity(0.4)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: TextFormField(
                    style: FontUtilities.h18(
                        fontColor: VariableUtilities.theme.keeptextColor),
                    decoration: InputDecoration(
                        hintText: "Search your notes",
                        hintStyle: FontUtilities.h18(
                          fontWeight: FWT.light,
                          fontColor: VariableUtilities.theme.keeptextColor,
                        ),
                        prefixIcon: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: VariableUtilities.theme.keeptextColor,
                            )),
                        border: InputBorder.none),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
