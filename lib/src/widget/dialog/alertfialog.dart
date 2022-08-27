import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/brushscreenprovider.dart';
import 'package:provider_app/utilities/asset/asset_utilities.dart';
import 'package:provider_app/utilities/font/font_utilities.dart';
import 'package:provider_app/utilities/settings/settings.dart';

Widget ShowAlertDailog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    backgroundColor: VariableUtilities.theme.backgroundColor,
    content: Container(
      height: 288,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Show grid',
            style: FontUtilities.h22(
                fontColor: VariableUtilities.theme.keeptextColor),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .onbrushbackgroundSelected(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Provider.of<BrushProvider>(context)
                                      .selectedbackgroundimage ==
                                  0
                              ? Colors.blue
                              : Colors.grey.shade800,
                          width: 2),
                      borderRadius: BorderRadius.circular(100)),
                  child: CircleAvatar(
                    radius: 24,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:
                            Image.asset(AssetUtilities.brushbackgroundimage1)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .onbrushbackgroundSelected(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Provider.of<BrushProvider>(context)
                                      .selectedbackgroundimage ==
                                  1
                              ? Colors.blue
                              : Colors.grey.shade800,
                          width: 2),
                      borderRadius: BorderRadius.circular(100)),
                  child: CircleAvatar(
                    radius: 24,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          AssetUtilities.brushbackgroundimage3,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Square  ',
                style: FontUtilities.h16(fontColor: Colors.grey.shade700),
              ),
              Text(
                'Dot   ',
                style: FontUtilities.h16(fontColor: Colors.grey.shade700),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .onbrushbackgroundSelected(2);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Provider.of<BrushProvider>(context)
                                      .selectedbackgroundimage ==
                                  2
                              ? Colors.blue
                              : Colors.grey.shade800,
                          width: 2),
                      borderRadius: BorderRadius.circular(100)),
                  child: CircleAvatar(
                    radius: 24,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:
                            Image.asset(AssetUtilities.brushbackgroundimage2)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .onbrushbackgroundSelected(3);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Provider.of<BrushProvider>(context)
                                      .selectedbackgroundimage ==
                                  3
                              ? Colors.blue
                              : Colors.grey.shade800,
                          width: 2),
                      borderRadius: BorderRadius.circular(100)),
                  child: CircleAvatar(
                    radius: 24,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          AssetUtilities.brushbackgroundimage4,
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Rules  ',
                style: FontUtilities.h16(fontColor: Colors.grey.shade700),
              ),
              Text(
                'None ',
                style: FontUtilities.h16(fontColor: Colors.grey.shade700),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Provider.of<BrushProvider>(context, listen: false)
                        .onAcceptButton();
                    Navigator.pop(context);
                  },
                  child: const Text('Accept')),
            ],
          )
        ],
      ),
    ),
  );
}
