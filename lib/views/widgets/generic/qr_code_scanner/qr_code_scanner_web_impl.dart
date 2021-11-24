// Note: only work over https or localhost
//
// thanks:
// - https://medium.com/@mk.pyts/how-to-access-webcam-video-stream-in-flutter-for-web-1bdc74f2e9c7
// - https://kevinwilliams.dev/blog/taking-photos-with-flutter-web
// - https://github.com/cozmo/jsQR

// ignore_for_file: avoid_web_libraries_in_flutter
// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:miro/views/widgets/generic/qr_code_scanner/types.dart';

// ignore_for_file: undefined_prefixed_name
///
///call global function jsQR
/// import https://github.com/cozmo/jsQR/blob/master/dist/jsQR.js on your index.html at web folder
///
js.JsObject? _jsQR(Uint8ClampedList d, int w, int h, Map<String, String> o) {
  return js.context.callMethod('jsQR', <dynamic>[d, w, h, o]) as js.JsObject?;
}

class QrCodeCameraWebImpl extends StatefulWidget {
  final QrCodeCallback qrCodeCallback;
  final BoxFit fit;
  final QrScannerErrorCallback? onError;

  const QrCodeCameraWebImpl({
    required this.qrCodeCallback,
    this.fit = BoxFit.cover,
    this.onError,
    Key? key,
  }) : super(key: key);

  @override
  _QrCodeCameraWebImplState createState() => _QrCodeCameraWebImplState();
}

class _QrCodeCameraWebImplState extends State<QrCodeCameraWebImpl> {
//  final double _width = 1000;
//  final double _height = _width / 4 * 3;
  final String _uniqueKey = UniqueKey().toString();

  //see https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/readyState
  // ignore: non_constant_identifier_names
  final int _HAVE_ENOUGH_DATA = 4;

  // Webcam widget to insert into the tree
  late Widget _videoWidget;

  // VideoElement
  late html.VideoElement _video;
  late Timer _timer;
  late html.CanvasElement _canvasElement;
  late html.CanvasRenderingContext2D _canvas;
  late html.MediaStream _stream;

  @override
  void initState() {
    super.initState();

    // Create a video element which will be provided with stream source
    _video = html.VideoElement();
    // Register an webcam
    ui.platformViewRegistry.registerViewFactory('webcamVideoElement$_uniqueKey', (int viewId) => _video);
    // Create video widget
    _videoWidget = HtmlElementView(key: UniqueKey(), viewType: 'webcamVideoElement$_uniqueKey');

    // Access the webcam stream
    html.window.navigator.getUserMedia(video: <String, String>{'facingMode': 'environment'})
//        .mediaDevices   //don't work rear camera
//        .getUserMedia({
//      'video': {
//        'facingMode': 'environment',
//      }
//    })
        .then((html.MediaStream stream) {
      _stream = stream;
      _video
        ..srcObject = stream
        ..setAttribute('playsinline', 'true')
        ..play();
    });
    _canvasElement = html.CanvasElement();
    _canvas = _canvasElement.getContext('2d') as html.CanvasRenderingContext2D;
    _timer = Timer.periodic(const Duration(milliseconds: 20), (Timer timer) {
      tick();
    });
  }

  bool waiting = false;

  void tick() {
    if (waiting) {
      return;
    }

    if (_video.readyState == _HAVE_ENOUGH_DATA) {
      waiting = true;
      _canvasElement
        ..width = 1024
        ..height = 1024;
      _canvas.drawImage(_video, 0, 0);
      html.ImageData imageData = _canvas.getImageData(0, 0, _canvasElement.width!, _canvasElement.height!);
      js.JsObject? code = _jsQR(imageData.data, imageData.width, imageData.height, <String, String>{
        'inversionAttempts': 'dontInvert',
      });
      waiting = false;
      if (code != null) {
        String value = code['data'] as String;
        widget.qrCodeCallback(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: FittedBox(
        fit: widget.fit,
        child: SizedBox(
          width: 400,
          height: 300,
          child: _videoWidget,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _video.pause();
    Future<void>.delayed(const Duration(seconds: 2), () {
      try {
        _stream.getTracks().forEach((html.MediaStreamTrack track) {
          track.stop();
        });
      } catch (e) {
        print('error on dispose qrcode: $e');
      }
    });
    super.dispose();
  }
}
