import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportationdriver/providers/driver_data.dart';

class Page0 extends StatefulWidget {
  const Page0({super.key});

  @override
  State<Page0> createState() => _Page0State();
}

class _Page0State extends State<Page0> {
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
                    "نام و نام خانوادگی:",
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
                    controller: Provider.of<DriverData>(context, listen: false)
                        .nameController,
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
                    "جنسیت:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight * 0.2),
                  child: Row(
                    children: [
                      ...Provider.of<DriverData>(context).sexualTypes.map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kToolbarHeight * 0.2),
                              child: Material(
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    Provider.of<DriverData>(context,
                                            listen: false)
                                        .changeSexualTypes(e);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kToolbarHeight * 0.2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .hintColor
                                            .withAlpha(60),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Radio(
                                          visualDensity: VisualDensity.compact,
                                          value: e,
                                          groupValue:
                                              Provider.of<DriverData>(context)
                                                  .selectedSexualTypes,
                                          onChanged: (_) {
                                            Provider.of<DriverData>(context,
                                                    listen: false)
                                                .changeSexualTypes(e);
                                          },
                                        ),
                                        Text(
                                          e,
                                          style: const TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(
                                            width: kToolbarHeight * 0.2),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
                    "آدرس:",
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
                    controller: Provider.of<DriverData>(context, listen: false)
                        .addressController,
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
                    "کد پستی:",
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
                    controller: Provider.of<DriverData>(context, listen: false)
                        .postalController,
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
                              Provider.of<DriverData>(context, listen: false)
                                  .setpageIndex(1);
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