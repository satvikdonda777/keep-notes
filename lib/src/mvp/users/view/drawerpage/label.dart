import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/labelprovider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';
import 'package:provider_app/src/widget/customrow/labelrow.dart';
import 'package:provider_app/utilities/route/route_utilities.dart';

import 'package:provider_app/utilities/utilities.dart';

TextEditingController textEditingController = TextEditingController();

class LabelPage extends StatefulWidget {
  const LabelPage({Key? key}) : super(key: key);

  @override
  State<LabelPage> createState() => _LabelPageState();
}

class _LabelPageState extends State<LabelPage> {
  @override
  void initState() {
    super.initState();
  }

  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VariableUtilities.theme.backgroundColor,
      body: SafeArea(
        child: Consumer<LabelProvider>(builder: (context, provider, child) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouteUtilities.userScreen, (route) => false);
                        Provider.of<UserProvider>(context, listen: false)
                            .selectedIndex = 0;
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: VariableUtilities.theme.drawerColor,
                      )),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    'Edit Labels',
                    style: FontUtilities.h18(
                        fontColor: VariableUtilities.theme.drawerColor),
                  )
                ],
              ),
              provider.isClosePressed
                  ? Container()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.grey,
                    ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        provider.toggleDivider();
                      },
                      icon: Icon(
                        provider.isClosePressed ? Icons.add : Icons.close,
                        color: VariableUtilities.theme.drawerColor,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  provider.isClosePressed
                      ? GestureDetector(
                          onTap: () {
                            provider.toggleDivider();
                          },
                          child: Text(
                            'Create new label',
                            style: FontUtilities.h16(
                                fontColor: VariableUtilities.theme.drawerColor),
                          ),
                        )
                      : Expanded(
                          child: Form(
                          key: formGlobalKey,
                          child: TextFormField(
                            autofocus: true,
                            style: FontUtilities.h18(
                                fontColor: VariableUtilities.theme.drawerColor),
                            controller: mainTextEditingController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                errorStyle:
                                    FontUtilities.h12(fontColor: Colors.red),
                                hintText: 'Create new label',
                                hintStyle: FontUtilities.h16(
                                    fontColor:
                                        VariableUtilities.theme.drawerColor)),
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid value';
                              } else {
                                return null;
                              }
                            }),
                          ),
                        )),
                  provider.isClosePressed
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            if (formGlobalKey.currentState!.validate()) {
                              provider.addlabeltoList();
                              provider.toggleDivider();
                              mainTextEditingController.clear();
                            }
                          },
                          icon: Icon(
                            Icons.check,
                            color: VariableUtilities.theme.drawerColor,
                          )),
                ],
              ),
              provider.isClosePressed
                  ? Container()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.grey,
                    ),
              Expanded(
                child: ListView.builder(
                    itemCount: provider.labelRow.length,
                    itemBuilder: (context, index) {
                      return Consumer<LabelProvider>(
                          builder: (context, provider, child) {
                        return LabelRowWidget(
                          data: provider.labelRow[index],
                          index: index,
                          onrowClick: () {
                            provider.onRowClick(index);
                          },
                          onlabelClick: () {},
                          onTextClick: () {
                            provider.onTextClicked(index);
                          },
                          oneditClick: () {
                            provider.onEditClicked(index);
                          },
                        );
                      });
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
