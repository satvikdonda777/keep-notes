// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/src/mvp/users/provider/checkboxnote_provider.dart';
import 'package:provider_app/src/mvp/users/provider/homepagelistprovider/catagory_provider.dart';
import 'package:provider_app/src/mvp/users/provider/recorderprovider.dart';
import 'package:provider_app/utilities/font/font_utilities.dart';
import 'package:provider_app/utilities/route/route_utilities.dart';
import 'package:provider_app/utilities/settings/settings.dart';

Widget recordingPermission() {
  return AlertDialog(
    backgroundColor: VariableUtilities.theme.backgroundColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    content: Consumer<RecorderProvider>(builder: (context, provider, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<RecordingDisposition>(
            stream: provider.recorder.onProgress,
            builder: (context, snapshot) {
              provider.duration =
                  snapshot.hasData ? snapshot.data!.duration : Duration.zero;
              String twoDigits(int n) => n.toString().padLeft(2, '0');
              final twoDigitMinutes =
                  twoDigits(provider.duration.inMinutes.remainder(60));
              final twoDigitSecond =
                  twoDigits(provider.duration.inSeconds.remainder(60));
              return Text(
                '$twoDigitMinutes:$twoDigitSecond',
                style: FontUtilities.h26(
                    fontColor: VariableUtilities.theme.keeptextColor,
                    fontWeight: FWT.bold),
              );
            },
          ),
          Consumer<RecorderProvider>(builder: (context, provider, child) {
            return GestureDetector(
              onTap: () {
                provider.startStopRecording();
                provider.isPlaying = false;
                provider.audioPlayer.stop();

                if (!provider.playAudio) {
                  Provider.of<AddScreenProvider>(context, listen: false)
                      .addscreen();
                  Navigator.pushNamed(
                    context,
                    RouteUtilities.addnotesScreen,
                  );
                  Provider.of<CategoryProvider>(context, listen: false)
                      .categorySelectedIndex = null;
                }
              },
              child: Icon(
                provider.playAudio ? Icons.pause : Icons.mic,
                size: 120,
                color: VariableUtilities.theme.keeptextColor,
              ),
            );
          }),
        ],
      );
    }),
  );
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}
