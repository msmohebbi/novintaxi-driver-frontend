// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FuncData with ChangeNotifier {
  showNotificationModal(Widget mainWidget, BuildContext ctx) {
    var widthPixFixed = MediaQuery.of(ctx).size.width;
    var heightPixFixed = MediaQuery.of(ctx).size.height;
    var widthPix = widthPixFixed;
    // int fontDelta = 0;
    var heightPix = heightPixFixed;
    bool isHorizontal = false;
    if (widthPix > heightPix ||
        MediaQuery.of(ctx).orientation == Orientation.landscape) {
      // fontDelta = 1;
      widthPix = heightPix;
      isHorizontal = true;
    }

    var modalWidget = StatefulBuilder(builder: (context, setSttt) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 5,
                    width: MediaQuery.of(context).size.width / 8,
                    decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withAlpha(120),
                        borderRadius: BorderRadius.circular(4)),
                  )
                ],
              ),
              mainWidget,
              const SizedBox(height: kToolbarHeight * 0.5)
            ],
          ),
        ),
      );
    });
    var horizontalWidget = StatefulBuilder(builder: (context, setSttt) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (widthPixFixed - widthPix) * 0.5,
            vertical:
                (heightPix - MediaQuery.of(context).viewInsets.bottom) * 0.15,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    mainWidget,
                  ]),
                ),
              ),
            ),
          ),
        ),
      );
    });
    if (isHorizontal) {
      showCupertinoDialog(
        barrierDismissible: true,
        context: ctx,
        builder: (context) {
          return horizontalWidget;
        },
      );
      return;
    }
    showModalBottomSheet(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: ctx,
      isDismissible: true,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxWidth: widthPix,
        minHeight: MediaQuery.of(ctx).size.height * 0.3,
        maxHeight: MediaQuery.of(ctx).size.height * 0.9,
      ),
      builder: (context) {
        return modalWidget;
      },
    );
  }

  Future<File?> pickImage(String source) async {
    final pickedImage = await ImagePicker().pickImage(
        source: source == "camera" ? ImageSource.camera : ImageSource.gallery);
    return pickedImage != null ? File(pickedImage.path) : null;
  }

  Future<File?> cropImage(File imageFile, BuildContext context) async {
    return File((await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      maxHeight: 1080,
      maxWidth: 1080,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),

      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   // CropAspectRatioPreset.ratio3x2,
      //   // CropAspectRatioPreset.original,
      //   // CropAspectRatioPreset.ratio4x3,
      //   // CropAspectRatioPreset.ratio16x9
      // ],
      // androidUiSettings: AndroidUiSettings(
      //     toolbarTitle: 'برش عکس',
      //     toolbarColor: Theme.of(context).colorScheme.background,
      //     toolbarWidgetColor: Theme.of(context).primaryColor,
      //     activeControlsWidgetColor: Theme.of(context).colorScheme.secondary,
      //     initAspectRatio: CropAspectRatioPreset.square,
      //     lockAspectRatio: true,
      //     hideBottomControls: false),
      // iosUiSettings: IOSUiSettings(
      //   title: 'برش عکس',
      // ),
    ))!
        .path);
  }

  downloadFile(String url, String filename) async {
    var httpClient = http.Client();
    var request = http.Request('GET', Uri.parse(url));
    var response = httpClient.send(request);
    String dir = (await getApplicationDocumentsDirectory()).path;

    List<List<int>> chunks = [];
    int downloaded = 0;

    response.asStream().listen((http.StreamedResponse r) {
      r.stream.listen((List<int> chunk) {
        // Display percentage of completion
        debugPrint(
            'downloadPercentage: ${downloaded / r.contentLength! * 100}');

        chunks.add(chunk);
        downloaded += chunk.length;
      }, onDone: () async {
        // Display percentage of completion
        debugPrint(
            'downloadPercentage: ${downloaded / r.contentLength! * 100}');

        // Save the file
        File file = File('$dir/$filename');
        final Uint8List bytes = Uint8List(r.contentLength!);
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }
        await file.writeAsBytes(bytes);
        return;
      });
    });
  }

  showSnack({
    required BuildContext ctx,
    required String mainText,
    required String? buttonText,
    required bool isError,
    required Function buttonFunc,
  }) {
    var widthPixFixed = MediaQuery.of(ctx).size.width;
    var heightPixFixed = MediaQuery.of(ctx).size.height;
    var widthPix = widthPixFixed;
    int fontDelta = 0;
    var heightPix = heightPixFixed;
    // bool isHorizontal = false;
    if (widthPix > heightPix ||
        MediaQuery.of(ctx).orientation == Orientation.landscape) {
      fontDelta = 1;
      widthPix = heightPix;
      // isHorizontal = true;
    }
    ScaffoldMessenger.of(ctx).clearSnackBars();
    // var sizee = MediaQuery.of(ctx).size;
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        // margin: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.1),
        elevation: 0,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // margin: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.1),

        behavior: SnackBarBehavior.fixed,
        duration: const Duration(seconds: 4),
        backgroundColor: Theme.of(ctx).hintColor,
        // width: sizee.width > sizee.height ? sizee.height : sizee.width,
        content: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            mainText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'IRANYekan',
              color: Theme.of(ctx).colorScheme.background,
              fontSize: fontDelta + 12,
            ),
          ),
        ),
        action: buttonText != null
            ? SnackBarAction(
                label: buttonText,
                textColor: isError
                    ? Theme.of(ctx).colorScheme.error
                    : Theme.of(ctx).cardColor,
                onPressed: () {
                  buttonFunc();
                },
              )
            : null,
      ),
    );
  }
}
