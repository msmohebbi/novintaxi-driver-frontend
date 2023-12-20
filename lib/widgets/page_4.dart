import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:novintaxidriver/providers/driver_data.dart';
import 'package:novintaxidriver/widgets/select_image.dart';

class Page4 extends StatefulWidget {
  final bool isScreen;

  const Page4({
    super.key,
    this.isScreen = false,
  });
  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
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
                  child: const Text('فرم مشخصات خودرو'),
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
                  padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "شماره پشت کارت خودرو:",
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
                  padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  margin: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: TextFormField(
                    readOnly: widget.isScreen,
                    controller: Provider.of<DriverData>(context).vehicleCartBackNo,
                    textInputAction: TextInputAction.next,
                    // autofocus: true,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (val) {
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(isDense: true, border: InputBorder.none, fillColor: Colors.blue, hintStyle: TextStyle()),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed && Provider.of<DriverData>(context).vehicleCartBackNo.text.trim().isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      'لطفا شماره پشت کارت خودرو را وارد کنید',
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
                  padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس از روی کارت خودرو:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false).setvehicleCartFrontImage(cFile);
                  },
                  currentImageUrl: Provider.of<DriverData>(context).cDriverVehicle?.vehicleCardImageFront,
                  selectedImage: Provider.of<DriverData>(context).vehicleCartFrontImage,
                  isReadOnly: widget.isScreen,
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed &&
                    Provider.of<DriverData>(context).vehicleCartFrontImage == null &&
                    Provider.of<DriverData>(context).cDriverVehicle?.vehicleCardImageFront == null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
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
                  padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس از پشت کارت خودرو:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false).setvehicleCartBackImage(cFile);
                  },
                  currentImageUrl: Provider.of<DriverData>(context).cDriverVehicle?.vehicleCardImageBack,
                  selectedImage: Provider.of<DriverData>(context).vehicleCartBackImage,
                  isReadOnly: widget.isScreen,
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed &&
                    Provider.of<DriverData>(context).vehicleCartBackImage == null &&
                    Provider.of<DriverData>(context).cDriverVehicle?.vehicleCardImageBack == null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
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
                // const Padding(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                //   child: Text(
                //     "عکس از بیرون و داخل خودرو:",
                //     style: TextStyle(),
                //   ),
                // ),
                // const SizedBox(height: kToolbarHeight * 0.2),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس اول (جلوی خودرو):",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false).setvehicleImage1(cFile);
                  },
                  currentImageUrl: Provider.of<DriverData>(context).cDriverVehicle?.vehicleImageFront,
                  selectedImage: Provider.of<DriverData>(context).vehicleImage1,
                  isReadOnly: widget.isScreen,
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed &&
                    Provider.of<DriverData>(context).vehicleImage1 == null &&
                    Provider.of<DriverData>(context).cDriverVehicle?.vehicleImageFront == null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس دوم (عقب خودرو):",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false).setvehicleImage2(cFile);
                  },
                  currentImageUrl: Provider.of<DriverData>(context).cDriverVehicle?.vehicleImageBack,
                  selectedImage: Provider.of<DriverData>(context).vehicleImage2,
                  isReadOnly: widget.isScreen,
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed &&
                    Provider.of<DriverData>(context).vehicleImage2 == null &&
                    Provider.of<DriverData>(context).cDriverVehicle?.vehicleImageBack == null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس سوم (داخل خودرو):",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false).setvehicleImage3(cFile);
                  },
                  currentImageUrl: Provider.of<DriverData>(context).cDriverVehicle?.vehicleImageIn,
                  selectedImage: Provider.of<DriverData>(context).vehicleImage3,
                  isReadOnly: widget.isScreen,
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed &&
                    Provider.of<DriverData>(context).vehicleImage3 == null &&
                    Provider.of<DriverData>(context).cDriverVehicle?.vehicleImageIn == null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
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
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
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
                                Provider.of<DriverData>(context, listen: false).setpageIndex(3);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: kTextTabBarHeight * 1.1,
                                child: Text(
                                  "بازگشت",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimary,
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
                                if (Provider.of<DriverData>(context, listen: false).vehicleCartBackNo.text.trim().isEmpty ||
                                    (Provider.of<DriverData>(context, listen: false).vehicleCartFrontImage == null &&
                                        Provider.of<DriverData>(context, listen: false).cDriverVehicle?.vehicleCardImageFront == null) ||
                                    (Provider.of<DriverData>(context, listen: false).vehicleCartBackImage == null &&
                                        Provider.of<DriverData>(context, listen: false).cDriverVehicle?.vehicleCardImageBack == null) ||
                                    (Provider.of<DriverData>(context, listen: false).vehicleImage1 == null &&
                                        Provider.of<DriverData>(context, listen: false).cDriverVehicle?.vehicleImageFront == null) ||
                                    (Provider.of<DriverData>(context, listen: false).vehicleImage2 == null &&
                                        Provider.of<DriverData>(context, listen: false).cDriverVehicle?.vehicleImageBack == null) ||
                                    (Provider.of<DriverData>(context, listen: false).vehicleImage3 == null &&
                                        Provider.of<DriverData>(context, listen: false).cDriverVehicle?.vehicleImageIn == null)) {
                                  return;
                                }
                                await Provider.of<DriverData>(context, listen: false).createDriver();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: kTextTabBarHeight * 1.1,
                                child: Provider.of<DriverData>(context).isUpdatingProfile
                                    ? CupertinoActivityIndicator(
                                        color: Theme.of(context).colorScheme.primary,
                                      )
                                    : Text(
                                        "تایید و ثبت نهایی",
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.primary,
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
