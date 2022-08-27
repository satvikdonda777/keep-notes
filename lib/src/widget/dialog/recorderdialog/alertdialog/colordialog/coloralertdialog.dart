import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/drawerprovider/reminderprovider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/mvp/users/provider/user_provider.dart';
import 'package:provider_app/utilities/font/font_utilities.dart';
import 'package:provider_app/utilities/settings/settings.dart';

class ColorAlertDialog extends StatefulWidget {
  int? index;
  ColorAlertDialog({this.index, Key? key}) : super(key: key);

  @override
  State<ColorAlertDialog> createState() => _ColorAlertDialogState();
}

class _ColorAlertDialogState extends State<ColorAlertDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderProvider>(builder: (context, provider, child) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: VariableUtilities.theme.backgroundColor,
        title: Text('Note Colour',
            style: FontUtilities.h24(
                fontColor: VariableUtilities.theme.keeptextColor,
                fontWeight: FWT.bold)),
        content: Container(
          height: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.colorDialog.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        return Consumer<CategoryProvider>(
                            builder: (context, provider, child) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              provider.setColor(context, index);
                            },
                            child: Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: provider.selectedIndex == index
                                          ? Colors.indigoAccent
                                          : Colors.grey,
                                      width: 2.5)),
                              child: CircleAvatar(
                                backgroundColor: provider.colorDialog[index],
                                child: provider.selectedIndex == index
                                    ? const Center(
                                        child: Icon(
                                          Icons.check,
                                          size: 40,
                                          color: Colors.indigoAccent,
                                        ),
                                      )
                                    : Container(),
                              ),
                            ),
                          );
                        });
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
