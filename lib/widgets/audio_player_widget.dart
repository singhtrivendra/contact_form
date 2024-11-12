import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class AudioRecordPage extends StatefulWidget {
  @override
  _AudioRecordPageState createState() => _AudioRecordPageState();
}

class _AudioRecordPageState extends State<AudioRecordPage> {
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    // Initialize the recorder without needing openAudioSession()
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    try {
      await _audioRecorder.openRecorder(); // Open the recorder directly
    } catch (e) {
      print('Error initializing recorder: $e');
    }
  }

  Future<void> _startRecording() async {
    try {
      // Start recording with a specified file path or null for temporary storage
      await _audioRecorder.startRecorder(
        toFile: 'audio_example.aac', // Provide the file path for recording
        codec: Codec.aacADTS, // Codec to use for the recording
      );
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      // Stop the recording
      await _audioRecorder.stopRecorder();
      setState(() {
        isRecording = false;
      });
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose the recorder when leaving the page
    _audioRecorder.closeRecorder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Audio Recording")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isRecording
                ? ElevatedButton(
                    onPressed: _stopRecording,
                    child: Text("Stop Recording"),
                  )
                : ElevatedButton(
                    onPressed: _startRecording,
                    child: Text("Start Recording"),
                  ),
          ],
        ),
      ),
    );
  }
}
