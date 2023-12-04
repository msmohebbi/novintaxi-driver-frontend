import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  var historyIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          const SizedBox(height: kToolbarHeight * 0.3),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              horizontal: kToolbarHeight * 0.5,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: kToolbarHeight * 0.2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withAlpha(50),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withAlpha(180),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('تاریخچه سفر ها'),
              ],
            ),
          ),
          const SizedBox(height: kToolbarHeight * 0.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kToolbarHeight * 0.1,
                ),
                child: Material(
                  color: historyIndex == 0
                      ? Theme.of(context).colorScheme.primary.withAlpha(50)
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        historyIndex = 0;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.15,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: historyIndex == 0
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(180)
                              : Theme.of(context).hintColor.withAlpha(180),
                        ),
                      ),
                      child: const Text('در حال انجام'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kToolbarHeight * 0.1,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: historyIndex == 1
                      ? Theme.of(context).colorScheme.primary.withAlpha(50)
                      : null,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        historyIndex = 1;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.15,
                        horizontal: kToolbarHeight * 0.4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: historyIndex == 1
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(180)
                              : Theme.of(context).hintColor.withAlpha(180),
                        ),
                      ),
                      child: const Text('انجام شده'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (historyIndex == 0) ...[
            const Expanded(
              child: Center(
                child: Text(
                  'در حال حاضر سفر درحال انجامی ندارید!',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
          if (historyIndex == 1) ...[
            const Expanded(
              child: Center(
                child: Text(
                  'تا کنون سفر انجام شده ای نداشته اید!',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
