import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transport_data.dart';

class SearchDriverScreen extends StatefulWidget {
  const SearchDriverScreen({super.key});

  @override
  State<SearchDriverScreen> createState() => _SearchDriverScreenState();
}

class _SearchDriverScreenState extends State<SearchDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(kToolbarHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: kToolbarHeight * 2),
                Image.asset(
                  'assets/images/search.png',
                ),
                const SizedBox(height: kToolbarHeight * 0.5),
                const Text(
                  'درحال جستجوی راننده برای شما',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 0.2),
                const Text(
                  'لطفا صبر کنید ...',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: kToolbarHeight * 2),
                Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.error,
                  child: InkWell(
                    onTap: () async {
                      await Provider.of<TransportData>(context, listen: false)
                          .cancelSearchTransportDriver();
                      if (mounted) {
                        if (Provider.of<TransportData>(
                              context,
                              listen: false,
                            ).cTransport?.status ==
                            'waiting') {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 0.2,
                        horizontal: kToolbarHeight * 2,
                      ),
                      child: Provider.of<TransportData>(context)
                              .isUpdatingTransport
                          ? const CupertinoActivityIndicator(
                              radius: kToolbarHeight * 0.2,
                            )
                          : const Text(
                              'لغو کردن',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
