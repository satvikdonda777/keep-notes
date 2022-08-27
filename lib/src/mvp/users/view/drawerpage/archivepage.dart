import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/mvp/users/provider/iconprovider/cusromicon_provider.dart';
import 'package:provider_app/src/widget/customicon/customicon.dart';
import 'package:provider_app/src/widget/drawer/drawer.dart';
import 'package:provider_app/src/widget/homescreen/checknotelist.dart';
import 'package:provider_app/utilities/font/font_utilities.dart';
import 'package:provider_app/utilities/settings/settings.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({Key? key}) : super(key: key);

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  var drawerKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      backgroundColor: VariableUtilities.theme.backgroundColor,
      drawer: CustomDrawer(context),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                    onPressed: () {
                      drawerKey.currentState!.openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      size: 26,
                      color: VariableUtilities.theme.drawerColor,
                    )),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  'Archive',
                  style: FontUtilities.h20(
                      fontColor: VariableUtilities.theme.keeptextColor),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: VariableUtilities.theme.keeptextColor,
                    )),
                const CustomIcon(),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<CategoryProvider>(builder: (context, provider, child) {
              return provider.archiveItemsList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: StaggeredGrid.count(
                        crossAxisCount:
                            Provider.of<CustomIconProvider>(context).isSelected
                                ? 2
                                : 1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 2,
                        children: List.generate(
                            provider.archiveItemsList.length, (index) {
                          return CheckNotesList(
                              index: index,
                              model: provider.archiveItemsList[index],
                              provider: provider);
                        }),
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 170,
                          ),
                          Icon(
                            Icons.delete_outline_outlined,
                            color: VariableUtilities.theme.bulbColor,
                            size: 200,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'No notes in Recycle Bin',
                            style: FontUtilities.h18(
                                fontColor:
                                    VariableUtilities.theme.keeptextColor),
                          )
                        ],
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }
}
