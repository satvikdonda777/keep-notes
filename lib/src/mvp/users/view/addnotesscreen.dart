import 'package:flutter/material.dart';
import 'package:provider_app/utilities/font/font_utilities.dart';
import 'package:provider_app/utilities/settings/settings.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({Key? key}) : super(key: key); 
 
  @override 
  State<AddNotesScreen> createState() => _AddNotesScreenState(); 
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.backgroundColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: VariableUtilities.theme.keeptextColor,
                      )),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.push_pin_outlined,
                        color: VariableUtilities.theme.keeptextColor,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notification_add_outlined,
                        color: VariableUtilities.theme.keeptextColor,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.archive_outlined,
                        color: VariableUtilities.theme.keeptextColor,
                      )),
                ],
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: TextFormField(
                  style: FontUtilities.h20(
                      fontWeight: FWT.regular,
                      fontColor: VariableUtilities.theme.keeptextColor),
                  decoration: InputDecoration(
                      suffixIcon: PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert_rounded,
                          color: VariableUtilities.theme.keeptextColor,
                        ),
                        color: VariableUtilities.theme.searchColor
                            .withOpacity(0.6),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                                child: Text(
                              'Hide checkboxes',
                              style: FontUtilities.h16(
                                  fontColor:
                                      VariableUtilities.theme.keeptextColor),
                            ))
                          ];
                        },
                      ),
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: FontUtilities.h22(
                          fontColor: VariableUtilities.theme.titlecolor)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(width: 12,),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
