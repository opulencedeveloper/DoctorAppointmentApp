// agora_rtc_engine: ^5.3.0
// permission_handler: ^10.0.0
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:permission_handler/permission_handler.dart';

const appId = "81acd12a610441e39ec3e8a5e7ffe858";
const token = "00681acd12a610441e39ec3e8a5e7ffe858IAAD6leCXKaFMGePE00hmt8axiU50UMqEXXMJUGXN2bDwf3VlhAAAAAAEAAtDEjTUZPfYgEAAQBQk99i";
const channel = "kudos";

class VideoCall extends StatefulWidget {
  static const routeName = './video-call-routeName';
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [
      Permission.microphone,
      Permission.camera
    ].request();

    //create the engine
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.joinChannel(token, channel, null, 0);
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        title: Text(
          'Doctor\'s Appointment',
          style: TextStyle(color: theme.secondary),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined ? const RtcLocalView.SurfaceView() : const CircularProgressIndicator(),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    elevation: 0,
                    fillColor: Colors.red,
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                    ),
                    //padding: EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                  )))
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: channel,
      );
    } else {
      return const Text(
        'Please wait for doctor to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
