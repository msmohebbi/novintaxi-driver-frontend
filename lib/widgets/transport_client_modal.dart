import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transport_data.dart';
import 'package:intl/intl.dart' as intl;

import '../providers/profile_data.dart';

class TransportClientModal extends StatefulWidget {
  const TransportClientModal({super.key});

  @override
  State<TransportClientModal> createState() => _TransportClientModalState();
}

class _TransportClientModalState extends State<TransportClientModal> {
  String? label;
  String? timelabel;

  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    changePassengerIsMe(bool newVal) {
      Provider.of<TransportData>(context, listen: false)
          .changePassengerIsMe(newVal);

      if (Provider.of<TransportData>(
        context,
      ).cPassengerIsMe) {
        Provider.of<TransportData>(context, listen: false).changeclientName(
            Provider.of<ProfileData>(context, listen: false)
                    .cUserProfile
                    ?.name ??
                "");
        Provider.of<TransportData>(context, listen: false).changeclientPhone(
            Provider.of<ProfileData>(context, listen: false)
                    .cUserProfile
                    ?.username ??
                "");
      } else {
        Provider.of<TransportData>(context, listen: false).changeclientName("");
        Provider.of<TransportData>(context, listen: false)
            .changeclientPhone("");
      }
    }

    var rialFormat = intl.NumberFormat.currency(
      // customPattern: "###",
      locale: "fa_IR",
      decimalDigits: 0,
      symbol: "",
      customPattern: kIsWeb ? "####################" : null,
    );
    // var sizee = MediaQuery.of(context).size;
    // var widthPix = sizee.width > sizee.height ? sizee.height : sizee.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
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
              child: Row(
                children: [
                  Text('سفر برای:'),
                ],
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
              child: Row(
                children: [
                  ...Provider.of<TransportData>(context)
                      .passengerTypes
                      .entries
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kToolbarHeight * 0.2),
                          child: Material(
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                changePassengerIsMe(e.key);
                              },
                              child: Container(
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
                                      value: e.key,
                                      groupValue:
                                          Provider.of<TransportData>(context)
                                              .cPassengerIsMe,
                                      onChanged: (_) {
                                        changePassengerIsMe(e.key);
                                      },
                                    ),
                                    Text(
                                      e.value,
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
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
              margin:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
              child: TextFormField(
                enabled: !Provider.of<TransportData>(context).cPassengerIsMe,
                controller: Provider.of<TransportData>(context, listen: false)
                    .clientNameController,
                textInputAction: TextInputAction.next,
                // autofocus: true,
                keyboardType: TextInputType.name,
                autovalidateMode: AutovalidateMode.always,
                validator: (val) {
                  // if (isNextPressed) {
                  //   if ((val ?? "").isEmpty) {
                  //     return "نام و نام خانوادگی را وارد کنید";
                  //   }
                  // }
                  return null;
                },
                decoration: const InputDecoration(
                    isDense: true,

                    // suffixIcon: myContactPicket,
                    border: InputBorder.none,
                    fillColor: Colors.blue,
                    labelText: "نام و نام خانوادگی",
                    hintStyle: TextStyle()),
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
              margin:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
              child: TextFormField(
                enabled: !Provider.of<TransportData>(context).cPassengerIsMe,
                controller: Provider.of<TransportData>(context, listen: false)
                    .clientPhoneController,
                textInputAction: TextInputAction.next,
                // autofocus: true,
                keyboardType: TextInputType.name,
                autovalidateMode: AutovalidateMode.always,
                validator: (val) {
                  // if (isNextPressed) {
                  //   if ((val ?? "").length != 11 || (val ?? "1")[0] != "0") {
                  //     return "شماره تماس معتبر وارد کنید";
                  //   }
                  // }
                  return null;
                },
                textDirection: TextDirection.ltr,
                decoration: const InputDecoration(
                    isDense: true,
                    hintTextDirection: TextDirection.ltr,
                    border: InputBorder.none,
                    fillColor: Colors.blue,
                    labelText: "شماره تماس",
                    hintStyle: TextStyle()),
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.3),
            Divider(
              height: 3,
              color: Theme.of(context).hintColor.withAlpha(60),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
              child: Row(
                children: [
                  Text('تعداد مسافر:'),
                ],
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight * 0.2,
                      vertical: kToolbarHeight * 0.05,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).hintColor.withAlpha(60),
                      ),
                    ),
                    child: Row(
                      children: [
                        // const SizedBox(width: kToolbarHeight * 0.2),
                        const Text(
                          'بزرگسال',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: kToolbarHeight * 0.1),
                        IconButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              CircleBorder(
                                  side: BorderSide(
                                color:
                                    Theme.of(context).hintColor.withAlpha(60),
                              )),
                            ),
                          ),
                          onPressed: () {
                            Provider.of<TransportData>(context, listen: false)
                                .changeAdultCount(1);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          visualDensity: VisualDensity.compact,
                          constraints: const BoxConstraints(
                            minHeight: kMinInteractiveDimension * 0.7,
                            minWidth: kMinInteractiveDimension * 0.7,
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          width: kToolbarHeight * 0.3,
                          child: Text(
                            rialFormat.format(
                                Provider.of<TransportData>(context)
                                    .cTransport
                                    ?.adult),
                          ),
                        ),

                        IconButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              CircleBorder(
                                  side: BorderSide(
                                color:
                                    Theme.of(context).hintColor.withAlpha(60),
                              )),
                            ),
                          ),
                          onPressed: () {
                            Provider.of<TransportData>(context, listen: false)
                                .changeAdultCount(-1);
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          visualDensity: VisualDensity.compact,
                          constraints: const BoxConstraints(
                            minHeight: kMinInteractiveDimension * 0.7,
                            minWidth: kMinInteractiveDimension * 0.7,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: kToolbarHeight * 0.2,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kToolbarHeight * 0.2,
                      vertical: kToolbarHeight * 0.05,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).hintColor.withAlpha(60),
                      ),
                    ),
                    child: Row(
                      children: [
                        // const SizedBox(width: kToolbarHeight * 0.2),
                        const Text(
                          'کودک',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: kToolbarHeight * 0.1),
                        IconButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              CircleBorder(
                                  side: BorderSide(
                                color:
                                    Theme.of(context).hintColor.withAlpha(60),
                              )),
                            ),
                          ),
                          onPressed: () {
                            Provider.of<TransportData>(context, listen: false)
                                .changeKidsCount(1);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          visualDensity: VisualDensity.compact,
                          constraints: const BoxConstraints(
                            minHeight: kMinInteractiveDimension * 0.7,
                            minWidth: kMinInteractiveDimension * 0.7,
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          width: kToolbarHeight * 0.3,
                          child: Text(
                            rialFormat.format(
                                Provider.of<TransportData>(context)
                                    .cTransport
                                    ?.child),
                          ),
                        ),

                        IconButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              CircleBorder(
                                  side: BorderSide(
                                color:
                                    Theme.of(context).hintColor.withAlpha(60),
                              )),
                            ),
                          ),
                          onPressed: () {
                            Provider.of<TransportData>(context, listen: false)
                                .changeKidsCount(-1);
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          visualDensity: VisualDensity.compact,
                          constraints: const BoxConstraints(
                            minHeight: kMinInteractiveDimension * 0.7,
                            minWidth: kMinInteractiveDimension * 0.7,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.3),
            Divider(
              height: 3,
              color: Theme.of(context).hintColor.withAlpha(60),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.4),
              child: Row(
                children: [
                  Text('گزینه های سفر:'),
                ],
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.2),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
              child: CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: kToolbarHeight * 0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: const Text("حیوان خانگی همراه دارم"),
                dense: true,
                visualDensity: VisualDensity.compact,
                controlAffinity: ListTileControlAffinity.leading,
                value: Provider.of<TransportData>(context).cTransport?.animal,
                onChanged: (newVal) {
                  Provider.of<TransportData>(context, listen: false)
                      .changeAnimal(newVal!);
                },
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
              child: CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: kToolbarHeight * 0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: const Text("بار حجیم دارم"),
                dense: true,
                visualDensity: VisualDensity.compact,
                controlAffinity: ListTileControlAffinity.leading,
                value:
                    Provider.of<TransportData>(context).cTransport?.extraLoad,
                onChanged: (newVal) {
                  Provider.of<TransportData>(context, listen: false)
                      .changeExtraLoad(newVal!);
                },
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
              child: CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: kToolbarHeight * 0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: const Text("نیاز به صدور فاکتور دارم"),
                dense: true,
                visualDensity: VisualDensity.compact,
                controlAffinity: ListTileControlAffinity.leading,
                value: Provider.of<TransportData>(context).cTransport?.invoice,
                onChanged: (newVal) {
                  Provider.of<TransportData>(context, listen: false)
                      .changeInvoice(newVal!);
                },
              ),
            ),
            const SizedBox(height: kToolbarHeight * 0.3),
            Divider(
              height: 3,
              color: Theme.of(context).hintColor.withAlpha(60),
            ),
            const SizedBox(height: kToolbarHeight * 0.3),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.2),
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
                          Provider.of<TransportData>(context, listen: false)
                              .setModalIndex(1);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: kTextTabBarHeight * 1.1,
                          child: Text(
                            "مرحله قبل",
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
                            isUpdating = true;
                          });
                          await Provider.of<TransportData>(context,
                                  listen: false)
                              .updateTransport();
                          setState(() {
                            isUpdating = false;
                          });
                          if (context.mounted) {
                            Provider.of<TransportData>(context, listen: false)
                                .setModalIndex(3);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: kTextTabBarHeight * 1.1,
                          child: isUpdating
                              ? CupertinoActivityIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : Text(
                                  "مرحله بعد",
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
            const SizedBox(height: kToolbarHeight * 0.2),
          ],
        ),
      ),
    );
  }
}
