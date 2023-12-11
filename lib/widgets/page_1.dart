import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:transportationdriver/providers/driver_data.dart';
import 'package:transportationdriver/widgets/select_image.dart';

class Page1 extends StatefulWidget {
  final bool isScreen;

  const Page1({
    super.key,
    this.isScreen = false,
  });
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  bool isNextPressed = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (!widget.isScreen) ...[
            const SizedBox(height: kToolbarHeight * 0.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kToolbarHeight * 0.5,
                    vertical: kToolbarHeight * 0.2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text('فرم مشخصات راننده'),
                ),
              ],
            ),
          ],
          const SizedBox(height: kToolbarHeight * 0.2),
          Container(
            margin: const EdgeInsets.all(kToolbarHeight * 0.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).hintColor.withAlpha(60),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kToolbarHeight * 0.2),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "کد ملی:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).hintColor.withAlpha(60),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight * 0.4),
                  margin: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight * 0.4),
                  child: TextFormField(
                    readOnly: widget.isScreen,
                    controller:
                        Provider.of<DriverData>(context).melliCodeController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: false,
                    ),
                    // autofocus: true,
                    onChanged: (value) {
                      setState(() {});
                    },
                    autovalidateMode: AutovalidateMode.always,
                    validator: (val) {
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        fillColor: Colors.blue,
                        hintStyle: TextStyle()),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed &&
                    Provider.of<DriverData>(context)
                            .melliCodeController
                            .text
                            .trim()
                            .length !=
                        10) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      'لطفا کد ملی صحیح وارد کنید',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: kToolbarHeight * 0.2),
                Divider(
                  color: Theme.of(context).hintColor.withAlpha(60),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس از روی کارت ملی:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false)
                        .setmelliFrontImage(cFile);
                  },
                  currentImageUrl: Provider.of<DriverData>(context)
                      .cDriverProfile
                      ?.nationalCardImageFront,
                  selectedImage:
                      Provider.of<DriverData>(context).melliFrontImage,
                  isReadOnly: widget.isScreen,
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed &&
                    Provider.of<DriverData>(context).melliFrontImage == null &&
                    Provider.of<DriverData>(context)
                            .cDriverProfile
                            ?.nationalCardImageFront ==
                        null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      "لطفا عکس را انتخاب کنید",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: kToolbarHeight * 0.2),
                Divider(
                  color: Theme.of(context).hintColor.withAlpha(60),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس از پشت کارت ملی:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false)
                        .setmelliBackImage(cFile);
                  },
                  currentImageUrl: Provider.of<DriverData>(context)
                      .cDriverProfile
                      ?.nationalCardImageBack,
                  selectedImage:
                      Provider.of<DriverData>(context).melliBackImage,
                  isReadOnly: widget.isScreen,
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed &&
                    Provider.of<DriverData>(context).melliBackImage == null &&
                    Provider.of<DriverData>(context)
                            .cDriverProfile
                            ?.nationalCardImageBack ==
                        null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      "لطفا عکس را انتخاب کنید",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
                if (!widget.isScreen) ...[
                  const SizedBox(height: kToolbarHeight),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kToolbarHeight * 0.2),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Material(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () async {
                                Provider.of<DriverData>(context, listen: false)
                                    .setpageIndex(0);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: kTextTabBarHeight * 1.1,
                                child: Text(
                                  "بازگشت",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: kToolbarHeight * 0.2),
                        Expanded(
                          flex: 3,
                          child: Material(
                            elevation: 0,
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () async {
                                setState(() {
                                  isNextPressed = true;
                                });
                                if ((Provider.of<DriverData>(context,
                                                    listen: false)
                                                .melliFrontImage ==
                                            null &&
                                        Provider.of<DriverData>(context,
                                                    listen: false)
                                                .cDriverProfile
                                                ?.nationalCardImageFront ==
                                            null) ||
                                    (Provider.of<DriverData>(context,
                                                    listen: false)
                                                .melliBackImage ==
                                            null &&
                                        Provider.of<DriverData>(context,
                                                    listen: false)
                                                .cDriverProfile
                                                ?.nationalCardImageBack ==
                                            null) ||
                                    Provider.of<DriverData>(context,
                                                listen: false)
                                            .melliCodeController
                                            .text
                                            .trim()
                                            .length !=
                                        10) {
                                  return;
                                }
                                Provider.of<DriverData>(context, listen: false)
                                    .setpageIndex(2);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: kTextTabBarHeight * 1.1,
                                child: Text(
                                  "ادامه",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: kToolbarHeight * 0.5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
