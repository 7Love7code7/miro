import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

typedef DropzoneUpload = void Function(String fileData);
typedef DropzoneUploadValidate = String? Function(String fileData);

class KiraDropZoneController {
  final DropzoneUpload? onFileUpload;

  html.File? file;
  String? fileData;

  KiraDropZoneController({
    this.onFileUpload,
  });

  bool get hasUploads {
    return file != null && fileData != null;
  }

  set uploadedFile(html.File newFile) {
    file = newFile;
  }

  set uploadedFileData(String data) {
    fileData = data;
  }
}

class KiraDropzone extends StatefulWidget {
  final KiraDropZoneController controller;
  final DropzoneUploadValidate? validate;

  const KiraDropzone({
    required this.controller,
    this.validate,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraDropzone();
}

class _KiraDropzone extends State<KiraDropzone> {
  late DropzoneViewController controller;
  html.File? uploadedFile;
  bool hasError = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.grey,
      child: Stack(
        children: <Widget>[
          DropzoneView(
            operation: DragOperation.all,
            cursor: CursorType.grab,
            onCreated: (DropzoneViewController ctrl) => controller = ctrl,
            // ignore: avoid_print
            onLoaded: () => print('Zone loaded'),
            // ignore: avoid_print
            onError: (String? ev) => print('Error: $ev'),
            // ignore: avoid_print
            onHover: () => print('Zone hovered'),
            // ignore: avoid_print
            onDrop: _onDrop,
            // ignore: avoid_print
            onLeave: () => print('Zone left'),
          ),
          if (uploadedFile == null)
            const Center(child: Text('Drop files here'))
          else
            Center(
              child: Column(
                children: <Widget>[
                  if (hasError) ...<Widget>[
                    const Icon(Icons.error),
                    Text(errorMessage!),
                  ],
                  Text(uploadedFile!.name),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _onDrop(dynamic file) {
    if (file is html.File) {
      setState(() {
        hasError = false;
        uploadedFile = file;
      });
      widget.controller.uploadedFile = file;
      final html.FileReader reader = html.FileReader()..readAsText(file);
      reader.onLoadEnd.listen((html.ProgressEvent event) {
        String result = reader.result.toString();
        widget.controller.uploadedFileData = result;
        String? validateMessage = widget.validate != null ? widget.validate!(result) : null;
        if (validateMessage != null) {
          setState(() {
            hasError = true;
            errorMessage = validateMessage;
          });
        } else if (widget.controller.onFileUpload != null) {
          {
            widget.controller.onFileUpload!(result);
          }
        }
      });
    }
  }
}
