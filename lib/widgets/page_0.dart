import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:novintaxidriver/providers/auth_data.dart';
import 'package:novintaxidriver/providers/driver_data.dart';
import 'package:novintaxidriver/widgets/select_image.dart';

class Page0 extends StatefulWidget {
  final bool isScreen;

  const Page0({
    super.key,
    this.isScreen = false,
  });

  @override
  State<Page0> createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  bool isNextPressed = false;

  @override
  Widget build(BuildContext context) {
    var regexp = RegExp(r'^[آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی ]+', caseSensitive: false, unicode: true, dotAll: true);
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
                  padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: Text(
                    "عکس پرسنلی:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                SelectImage(
                  onSelectImage: (cFile) {
                    Provider.of<DriverData>(context, listen: false).setpersonalImage(cFile);
                  },
                  currentImageUrl: Provider.of<DriverData>(context).cDriver?.personalImage,
                  selectedImage: Provider.of<DriverData>(context).personalImage,
                  isReadOnly: widget.isScreen,
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed &&
                    Provider.of<DriverData>(context).personalImage == null &&
                    Provider.of<DriverData>(context).cDriver?.personalImage == null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      "لطفا عکس پرسنلی را انتخاب کنید",
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
                  padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  margin: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: TextFormField(
                    readOnly: widget.isScreen,
                    controller: Provider.of<DriverData>(context).nameController,
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        regexp,
                      )
                    ],
                    decoration: const InputDecoration(isDense: true, border: InputBorder.none, fillColor: Colors.blue, hintStyle: TextStyle()),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed && Provider.of<DriverData>(context).nameController.text.trim().isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      'لطفا نام و نام خانوادگی را وارد کنید',
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
                    "جنسیت:",
                    style: TextStyle(),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
                  child: Row(
                    children: [
                      ...Provider.of<DriverData>(context).sexualTypes.map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
                              child: Material(
                                borderRadius: BorderRadius.circular(12),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    if (widget.isScreen) {
                                      return;
                                    }
                                    Provider.of<DriverData>(context, listen: false).changeSexualTypes(e);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Theme.of(context).hintColor.withAlpha(60),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Radio(
                                          visualDensity: VisualDensity.compact,
                                          value: e,
                                          groupValue: Provider.of<DriverData>(context).selectedSexualTypes,
                                          onChanged: (_) {
                                            if (widget.isScreen) {
                                              return;
                                            }
                                            Provider.of<DriverData>(context, listen: false).changeSexualTypes(e);
                                          },
                                        ),
                                        Text(
                                          e,
                                          style: const TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(width: kToolbarHeight * 0.2),
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
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed && Provider.of<DriverData>(context).selectedSexualTypes == null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      "لطفا جنسیت را انتخاب کنید",
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
                  padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  margin: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: TextFormField(
                    readOnly: widget.isScreen,
                    controller: Provider.of<DriverData>(context).addressController,
                    textInputAction: TextInputAction.next,
                    // autofocus: true,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      setState(() {});
                    },
                    autovalidateMode: AutovalidateMode.always,
                    validator: (val) {
                      return null;
                    },
                    decoration: const InputDecoration(isDense: true, border: InputBorder.none, fillColor: Colors.blue, hintStyle: TextStyle()),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed && Provider.of<DriverData>(context).addressController.text.trim().length < 10) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      'لطفا آدرس کامل وارد کنید',
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
                  padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  margin: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                  child: TextFormField(
                    readOnly: widget.isScreen,
                    controller: Provider.of<DriverData>(context).postalController,
                    textInputAction: TextInputAction.next,
                    // autofocus: true,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: false,
                    ),

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
                    decoration: const InputDecoration(isDense: true, border: InputBorder.none, fillColor: Colors.blue, hintStyle: TextStyle()),
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                if (isNextPressed && Provider.of<DriverData>(context).postalController.text.trim().length != 10) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
                    child: Text(
                      'لطفا کدپستی صحیح وارد کنید',
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
                          flex: 3,
                          child: Material(
                            color: Theme.of(context).colorScheme.error,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () async {
                                showCupertinoDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: CupertinoAlertDialog(
                                        title: const Text(
                                          'شما درحال خروج از حساب کاربری خود هستید، \n آیا مطمئن هستید',
                                          style: TextStyle(
                                            height: 2,
                                            fontSize: 13,
                                            fontFamily: 'IRANYekan',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        actions: [
                                          IconButton(
                                            onPressed: () async {
                                              await Provider.of<AuthData>(context, listen: false).signOut();

                                              if (mounted) {
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            icon: Icon(
                                              Icons.check,
                                              color: Theme.of(context).colorScheme.error,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: kTextTabBarHeight * 1.1,
                                child: Text(
                                  "خروج از حساب کاربری",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.background,
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
                                if ((Provider.of<DriverData>(context, listen: false).personalImage == null &&
                                        Provider.of<DriverData>(context, listen: false).cDriver?.personalImage == null) ||
                                    Provider.of<DriverData>(context, listen: false).nameController.text.trim().isEmpty ||
                                    Provider.of<DriverData>(context, listen: false).selectedSexualTypes == null ||
                                    Provider.of<DriverData>(context, listen: false).addressController.text.trim().length < 10 ||
                                    Provider.of<DriverData>(context, listen: false).postalController.text.trim().length != 10) {
                                  return;
                                }
                                Provider.of<DriverData>(context, listen: false).setpageIndex(1);
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
