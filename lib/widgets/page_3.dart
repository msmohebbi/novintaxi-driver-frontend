import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:novintaxidriver/providers/driver_data.dart';

class Page3 extends StatefulWidget {
  final bool isScreen;

  const Page3({
    super.key,
    this.isScreen = false,
  });
  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
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
                    "مدل خودرو:",
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
                    controller: Provider.of<DriverData>(context).vehicleModel,
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
                if (isNextPressed && Provider.of<DriverData>(context).vehicleModel.text.trim().isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      'لطفا مدل خودرو را وارد کنید',
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
                    "رنگ خودرو:",
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
                    controller: Provider.of<DriverData>(context).vehicleColor,
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
                if (isNextPressed && Provider.of<DriverData>(context).vehicleColor.text.trim().isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      'لطفا رنگ خودرو را وارد کنید',
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
                    "پلاک خودرو:",
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
                    controller: Provider.of<DriverData>(context).vehiclePelak,
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
                if (isNextPressed && Provider.of<DriverData>(context).vehiclePelak.text.trim().isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      'لطفا پلاک خودرو را وارد کنید',
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
                                Provider.of<DriverData>(context, listen: false).setpageIndex(2);
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
                                if (Provider.of<DriverData>(context, listen: false).vehicleModel.text.trim().isEmpty ||
                                    Provider.of<DriverData>(context, listen: false).vehicleColor.text.trim().isEmpty ||
                                    Provider.of<DriverData>(context, listen: false).vehiclePelak.text.trim().isEmpty) {
                                  return;
                                }
                                Provider.of<DriverData>(context, listen: false).setpageIndex(4);
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
