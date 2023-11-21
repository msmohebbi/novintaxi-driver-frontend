import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectImage extends StatefulWidget {
  final void Function(File cFile) onSelectImage;

  final File? selectedImage;
  final String? currentImageUrl;

  const SelectImage({
    super.key,
    required this.onSelectImage,
    this.currentImageUrl,
    this.selectedImage,
  });

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  File? tempFile;
  @override
  void initState() {
    tempFile = widget.selectedImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tempFile != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: Image.file(
                    tempFile!,
                    fit: BoxFit.contain,
                  )),
            ],
          ),
          const SizedBox(height: kToolbarHeight * 0.2),
        ] else if (widget.currentImageUrl != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: CachedNetworkImage(
                    imageUrl: widget.currentImageUrl!,
                    fit: BoxFit.contain,
                  )),
            ],
          ),
          const SizedBox(height: kToolbarHeight * 0.2),
        ],
        const SizedBox(height: kToolbarHeight * 0.2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    var pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        tempFile = File(pickedFile.path);
                      });
                      widget.onSelectImage(tempFile!);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight * 0.4,
                      vertical: kToolbarHeight * 0.2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).hintColor.withAlpha(60),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'انتخاب از گالری',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: kToolbarHeight * 0.3),
              Material(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    var pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 50,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        tempFile = File(pickedFile.path);
                      });
                      widget.onSelectImage(tempFile!);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight * 0.4,
                      vertical: kToolbarHeight * 0.2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).hintColor.withAlpha(60),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'عکس گرفتن',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
