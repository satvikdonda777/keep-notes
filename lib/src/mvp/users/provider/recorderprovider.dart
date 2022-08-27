// ignore_for_file: public_member_api_docs

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider_app/src/mvp/users/view/user_screen.dart';
import 'package:provider_app/src/widget/dialog/recorderdialog/recorderdialog.dart';

class RecorderProvider extends ChangeNotifier {
  final recorder = FlutterSoundRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isRecorderReady = false;
  bool isRepeat = false;
  bool isPlaying = false;
  bool isPlayingStream = false;
  String? path;
  bool playAudio = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  void askethepermissionforrecording(BuildContext context) async {
    if (path != null) {
      await recorder.deleteRecord(fileName: 'audio');
    }
    final status = await Permission.microphone.request();

    if (status == PermissionStatus.granted) {
      await initRecorder();
      position = const Duration(seconds: 0);
      isDialogOpen = true;

      await showDialog(
          context: context,
          builder: (context) {
            return recordingPermission();
          }).then((value) => isDialogOpen = false);
      if (isDialogOpen == false) {
        await audioPlayer.stop();
        await recorder.stopRecorder();
        playAudio = false;
        notifyListeners();
      }
    } else if (status == PermissionStatus.denied) {
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
    notifyListeners();
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
    notifyListeners();
  }

  void repeatStop() {
    if (isRepeat == false) {
      audioPlayer.setReleaseMode(ReleaseMode.release);
      audioPlayer.onPlayerComplete.listen((event) {
        isPlaying = false;
        isPlayingStream = false;

        notifyListeners();
      });
    }
    notifyListeners();
  }

  Future stop() async {
    if (!isRecorderReady) return;
    path = await recorder.stopRecorder();
    isRecorderReady = true;
    notifyListeners();
    // audioFile = File(path!);
    print('Recorder audio $path');
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
    await recorder.setSubscriptionDuration(const Duration(milliseconds: 10));
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    isRecorderReady = true;
    //await recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  void startStopRecording() {
    if (recorder.isRecording) {
      stop();
      setAudio();
    } else {
      record();
    }

    playAudio = !playAudio;
    notifyListeners();
  }

  void onPlayerStateChanged() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
    });

    notifyListeners();
  }

  void onDurationChanged() {
    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
    });

    notifyListeners();
  }

  void onAudioPositionChanged() {
    audioPlayer.onPositionChanged.listen((newPosition) {
      print('Position CHANGES');
      position = newPosition;

      notifyListeners();
    });
  }

  void listenAudioPositionChanges() async {
    while (isPlayingStream) {
      await Future.delayed(const Duration(milliseconds: 200));
      position =
          await audioPlayer.getCurrentPosition() ?? const Duration(seconds: 0);

      notifyListeners();
    }
  }

  void listenRecording() async {
    isPlayingStream = !isPlayingStream;
    if (isPlaying == true) {
      isPlaying = false;
      await audioPlayer.pause();
      notifyListeners();
    } else if (isPlaying == false) {
      isPlaying = true;
      await audioPlayer.resume();
      notifyListeners();
    }

    listenAudioPositionChanges();

    notifyListeners();
  }

  void deleteAudio() {
    path = null;
    notifyListeners();
  }

  Future setAudio() async {
    await audioPlayer.setReleaseMode(ReleaseMode.loop);
    //await audioPlayer.setSourceDeviceFile(audioFile);
    await audioPlayer.setSourceUrl(path!);
    notifyListeners();
    //load audio from file
    // final file=File(audioFile);
    // await audioPlayer.setSourceUrl(file.path);

    //LOAD AUDIO FROM FILE
    // final result=await FilePicker.platform.pickFile();
    // if(result!=null){
    // final file=File(result.file.single.path!);

    // }

    //load audion from ASSETS
    //   final player=AudioCache(prefix: 'assets/');
    //   final url=await player.load('audio1.mp3');
    //  await audioPlayer.setSourceUrl(url.path,);
  }
}
