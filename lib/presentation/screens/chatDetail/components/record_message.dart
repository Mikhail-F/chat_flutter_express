import 'dart:async';
import 'dart:io';

import 'package:auth_flutter_express/presentation/screens/chatDetail/components/audio_player.dart';
import 'package:flutter/material.dart';
// import 'package:pick_or_save/pick_or_save.dart';
import 'package:record/record.dart';

class RecordMessage extends StatefulWidget {
  const RecordMessage({super.key});

  @override
  State<RecordMessage> createState() => _RecordMessageState();
}

class _RecordMessageState extends State<RecordMessage> {
  int _recordDuration = 0;
  Timer? _timer;
  final _audioRecorder = AudioRecorder();
  StreamSubscription<RecordState>? _recordStateSubscription;
  String _audioPath = "";
  RecordState _recordState = RecordState.stop;

  @override
  void initState() {
    _recordStateSubscription = _audioRecorder.onStateChanged().listen((recordState) {
      if (!mounted) return;
      setState(() => _recordState = recordState);
    });

    super.initState();
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (!isSupported) return;

        final outputPath =
            '${Directory.systemTemp.path}/record_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc),
          path: outputPath,
        );
        _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      debugPrint('Record start failed: $e');
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _recordDuration = 0;
    final path = await _audioRecorder.stop();

    if (path == null || path.isEmpty) return;
    _audioPath = path;
    setState(() {});
    // File file = File(path.toString());
    // List<String>? result = await PickOrSave().fileSaver(
    //     params: FileSaverParams(
    //   localOnly: true,
    //   saveFiles: [SaveFileInfo(filePath: file.path, fileName: "Мой звук")],
    // ));
    // print(result);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordStateSubscription?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _audioPath.isNotEmpty
        ? AudioPlayer(
            source: _audioPath,
            onDelete: () {
              setState(() => _audioPath = '');
            },
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_recordState == RecordState.record)
                Text(_recordDuration.toString()),
              const SizedBox(width: 20),
              SizedBox(
                height: 50,
                child: InkWell(
                  onTapUp: (tap) {
                    if (_recordState == RecordState.record) _stop();
                  },
                  onLongPress: _start,
                  child: ClipOval(
                    child: Container(
                        width: 50,
                        height: 50,
                        color: _recordState == RecordState.stop
                            ? Colors.green
                            : Colors.red,
                        child: Icon(
                          _recordState == RecordState.stop
                              ? Icons.mic
                              : Icons.stop,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ],
          );
  }
}
