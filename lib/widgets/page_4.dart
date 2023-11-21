import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportationdriver/providers/driver_data.dart';
import 'package:transportationdriver/widgets/select_image.dart';

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight * 0.4),
                  margin: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight * 0.4),
                  child: TextFormField(
                    controller:
                        Provider.of<DriverData>(context).vehicleCartBackNo,
                    textInputAction: TextInputAction.next,
                    // autofocus: true,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (val) {
                      return null;
                    },
                    decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        fillColor: Colors.blue,
                        hintStyle: TextStyle()),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.4),
                Divider(
                  color: Theme.of(context).hintColor.withAlpha(60),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس از روی کارت خودرو:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false)
                        .setvehicleCartFrontImage(cFile);
                  },
                  selectedImage:
                      Provider.of<DriverData>(context).vehicleCartFrontImage,
                ),
                const SizedBox(height: kToolbarHeight * 0.4),
                Divider(
                  color: Theme.of(context).hintColor.withAlpha(60),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس از پشت کارت خودرو:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false)
                        .setvehicleCartBackImage(cFile);
                  },
                  selectedImage:
                      Provider.of<DriverData>(context).vehicleCartBackImage,
                ),
                const SizedBox(height: kToolbarHeight * 0.4),
                Divider(
                  color: Theme.of(context).hintColor.withAlpha(60),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس از بیرون و داخل خودرو:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس اول (جلوی خودرو):",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false)
                        .setmelliBackImage(cFile);
                  },
                  selectedImage:
                      Provider.of<DriverData>(context).melliBackImage,
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس دوم (عقب خودرو):",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false)
                        .setmelliBackImage(cFile);
                  },
                  selectedImage:
                      Provider.of<DriverData>(context).melliBackImage,
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس سوم (داخل خودرو):",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false)
                        .setmelliBackImage(cFile);
                  },
                  selectedImage:
                      Provider.of<DriverData>(context).melliBackImage,
                ),
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
                                  .setpageIndex(3);
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
                              Provider.of<DriverData>(context, listen: false)
                                  .setpageIndex(4);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: kTextTabBarHeight * 1.1,
                              child: Text(
                                "تایید و ادامه",
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
                const SizedBox(height: kToolbarHeight * 0.5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
