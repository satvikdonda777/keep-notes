import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/brushscreenprovider.dart';
import 'package:provider_app/utilities/utilities.dart';

class BrushColorScreen extends StatefulWidget {
  const BrushColorScreen({Key? key}) : super(key: key);

  @override
  State<BrushColorScreen> createState() => _BrushColorScreenState();
}

class _BrushColorScreenState extends State<BrushColorScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExpansionTile(
              childrenPadding: const EdgeInsets.only(left: 16),
              expandedAlignment: Alignment.centerLeft,
              title: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<BrushProvider>(context, listen: false)
                              .selecttitleColor(index);
                        },
                        child: CircleAvatar(
                          radius: titleColorselectedindex == index ? 17 : 14,
                          backgroundColor: Provider.of<BrushProvider>(context)
                              .brushColorlist[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 70,
                  child: Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 10,
                    children: List.generate(
                        Provider.of<BrushProvider>(context)
                            .expansiotileColorList
                            .length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<BrushProvider>(context, listen: false)
                                .selectColor(index);
                          },
                          child: CircleAvatar(
                            radius: Provider.of<BrushProvider>(
                                      context,
                                    ).colorselectedindex ==
                                    index
                                ? 17
                                : 14,
                            backgroundColor: Provider.of<BrushProvider>(context)
                                .expansiotileColorList[index],
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ]),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .checkCirlceselected(0);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: VariableUtilities.theme.transparent,
                          border: Border.all(
                              color: Provider.of<BrushProvider>(context)
                                          .circleSelected ==
                                      0
                                  ? VariableUtilities.theme.keeptextColor
                                  : VariableUtilities.theme.transparent),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: VariableUtilities.theme.keeptextColor,
                        radius: 1,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .checkCirlceselected(1);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: VariableUtilities.theme.transparent,
                          border: Border.all(
                              color: Provider.of<BrushProvider>(context)
                                          .circleSelected ==
                                      1
                                  ? VariableUtilities.theme.keeptextColor
                                  : VariableUtilities.theme.transparent),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: VariableUtilities.theme.keeptextColor,
                        radius: 3,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .checkCirlceselected(2);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: VariableUtilities.theme.transparent,
                          border: Border.all(
                              color: Provider.of<BrushProvider>(context)
                                          .circleSelected ==
                                      2
                                  ? VariableUtilities.theme.keeptextColor
                                  : VariableUtilities.theme.transparent),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: VariableUtilities.theme.keeptextColor,
                        radius: 5,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .checkCirlceselected(3);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: VariableUtilities.theme.transparent,
                          border: Border.all(
                              color: Provider.of<BrushProvider>(context)
                                          .circleSelected ==
                                      3
                                  ? VariableUtilities.theme.keeptextColor
                                  : VariableUtilities.theme.transparent),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: VariableUtilities.theme.keeptextColor,
                        radius: 6,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .checkCirlceselected(4);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: VariableUtilities.theme.transparent,
                          border: Border.all(
                              color: Provider.of<BrushProvider>(context)
                                          .circleSelected ==
                                      4
                                  ? VariableUtilities.theme.keeptextColor
                                  : VariableUtilities.theme.transparent),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: VariableUtilities.theme.keeptextColor,
                        radius: 7,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .checkCirlceselected(5);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: VariableUtilities.theme.transparent,
                          border: Border.all(
                              color: Provider.of<BrushProvider>(context)
                                          .circleSelected ==
                                      5
                                  ? VariableUtilities.theme.keeptextColor
                                  : VariableUtilities.theme.transparent),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: VariableUtilities.theme.keeptextColor,
                        radius: 8,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .checkCirlceselected(6);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: VariableUtilities.theme.transparent,
                          border: Border.all(
                              color: Provider.of<BrushProvider>(context)
                                          .circleSelected ==
                                      6
                                  ? VariableUtilities.theme.keeptextColor
                                  : VariableUtilities.theme.transparent),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: VariableUtilities.theme.keeptextColor,
                        radius: 9,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BrushProvider>(context, listen: false)
                      .checkCirlceselected(7);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: VariableUtilities.theme.transparent,
                          border: Border.all(
                              color: Provider.of<BrushProvider>(context)
                                          .circleSelected ==
                                      7
                                  ? VariableUtilities.theme.keeptextColor
                                  : VariableUtilities.theme.transparent),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: VariableUtilities.theme.keeptextColor,
                        radius: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
