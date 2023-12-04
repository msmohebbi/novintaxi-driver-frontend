import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/faq_data.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    var widthPixFixed = MediaQuery.of(context).size.width;
    var heightPixFixed = MediaQuery.of(context).size.height;
    var widthPix = widthPixFixed;
    var heightPix = heightPixFixed;
    // bool isHorizontal = false;
    int fontDelta = 0;
    if (widthPix > heightPix ||
        MediaQuery.of(context).orientation == Orientation.landscape) {
      fontDelta = 1;
      widthPix = heightPix;
      // isHorizontal = true;
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "سوالات متداول",
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: fontDelta + 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: !Provider.of<FAQData>(context).isInitialized
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "در حال بارگزاری سوالات متداول ...",
                    style: TextStyle(
                      fontSize: fontDelta + 11,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Column(
                children: [
                  ...Provider.of<FAQData>(context)
                      .allFAQs
                      .map((e) => ExpansionTile(
                            expandedAlignment: Alignment.centerRight,
                            title: Text(
                              e.question,
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: fontDelta + 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  e.answer,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: fontDelta + 11,
                                  ),
                                ),
                              ),
                            ],
                          ))
                ],
              ),
      ),
    );
  }
}
