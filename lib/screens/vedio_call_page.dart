import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCallPage extends StatefulWidget {
  final String callerName;

  VideoCallPage({required this.callerName});

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  @override
  void initState() {
    super.initState();
    _initializeRenderers();
    _startCall();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _peerConnection?.close();
    super.dispose();
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    _createLocalStream();
  }

  Future<void> _createLocalStream() async {
    // Get the media stream (video + audio) from the front-facing (selfie) camera
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user', // 'user' is for the front camera
      }
    };

    try {
      _localStream =
          await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _localRenderer.srcObject = _localStream; // Display the local stream
    } catch (e) {
      print('Error getting user media: $e');
    }
  }

  Future<void> _startCall() async {
    // Initialize peer connection configuration
    final Map<String, dynamic> configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ]
    };

    _peerConnection = await createPeerConnection(configuration);

    // Add local stream tracks to peer connection
    _localStream?.getTracks().forEach((track) {
      _peerConnection?.addTrack(track, _localStream!);
    });

    // Set up remote stream rendering
    _peerConnection?.onTrack = (RTCTrackEvent event) {
      if (event.track.kind == 'video') {
        setState(() {
          _remoteRenderer.srcObject = event.streams[0]; // Display remote stream
        });
      }
    };

    // Implement signaling logic here (offer/answer exchange, ICE candidates)
    // e.g., send SDP offer, receive SDP answer, and add ICE candidates
  }

  // Function to handle hanging up the call
  void _hangUp() {
    // Close the peer connection and pop the page
    _peerConnection?.close();
    _peerConnection = null;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call with ${widget.callerName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.call_end, color: Colors.red),
            onPressed: _hangUp,
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: RTCVideoView(_remoteRenderer), // Remote video view
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              width: 120,
              height: 180,
              child: RTCVideoView(
                  _localRenderer), // Local selfie camera video view
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
