import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:transportationdriver/providers/driver_data.dart';
import 'package:transportationdriver/widgets/select_image.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
                child: const Text('فرم مشخصات راننده'),
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
                    "شماره گواهینامه:",
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
                        Provider.of<DriverData>(context).govahiCodeController,
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
                  child: Row(
                    children: [
                      Text('مدت اعتبار گواهینامه:'),
                    ],
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight * 0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("تاریخ:"),
                      const SizedBox(width: kToolbarHeight * 0.2),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {
                          Jalali? picked = await showPersianDatePicker(
                            context: context,
                            initialDate: Jalali.now(),
                            firstDate: Jalali.now(),
                            lastDate: Jalali.now().addDays(7),
                            builder: (context, child) {
                              return Theme(data: ThemeData(), child: child!);
                            },
                          );
                          if (picked != null && context.mounted) {
                            Provider.of<DriverData>(context, listen: false)
                                .setgovahiExpDate(picked.toDateTime());
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(kToolbarHeight * 0.1),
                          child: Text(Provider.of<DriverData>(context)
                                  .govahiExpDateString ??
                              "انتخاب کنید"),
                        ),
                      ),
                    ],
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
                    "عکس از روی گواهینامه:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false)
                        .setgovahiFrontImage(cFile);
                  },
                  selectedImage:
                      Provider.of<DriverData>(context).govahiFrontImage,
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
                    "عکس از پشت گواهینامه:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false)
                        .setgovahiBackImage(cFile);
                  },
                  selectedImage:
                      Provider.of<DriverData>(context).govahiBackImage,
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
                                  .setpageIndex(1);
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
                                  .setpageIndex(3);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: kTextTabBarHeight * 1.1,
                              child: Text(
                                "ادامه",
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
