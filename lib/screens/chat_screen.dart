import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_data.dart';
import '../models/chat_massage_model.dart';
import '../providers/message_data.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var regexp = RegExp(r'^[آابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]+',
      caseSensitive: false, unicode: true, dotAll: true);
  var msgctrl = TextEditingController(text: "");
  void sendTextMassage() async {
    setState(() {
      Provider.of<MessageData>(context, listen: false).addSupportMessage(
          AppChatMassage(
              id: -1,
              sender: Provider.of<ProfileData>(context, listen: false)
                  .cUserProfile!
                  .userId,
              text: msgctrl.text.trim(),
              date: DateTime.now().millisecondsSinceEpoch));

      msgctrl.text = "";
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  final ScrollController _scrollController = ScrollController();

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
    var allMassages = Provider.of<MessageData>(context).supportMessageList;
    // User? cuser = FirebaseAuth.instance.currentUser;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        child: Scaffold(
          appBar: AppBar(
            primary: true,
            elevation: 1,
            toolbarHeight: kToolbarHeight,
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
              "ارتباط با پشتیبانی",
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: fontDelta + 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                // SizedBox(
                // height: (MediaQuery.of(context).size.height -
                //     MediaQuery.of(context).viewPadding.top -
                //     MediaQuery.of(context).viewPadding.bottom -
                //     MediaQuery.of(context).viewInsets.bottom -
                //     (AppBar().preferredSize.height * 2)),
                child: allMassages.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "شما میتوانید سوالات، انتقادات و پیشنهادات خود را در این مکالمه با ما مطرح کنید",
                            style: TextStyle(
                              fontSize: fontDelta + 11,
                              color: Theme.of(context).primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        itemBuilder: (BuildContext bcontext, int ind) {
                          var textString = allMassages[ind].text;
                          var isSend = allMassages[ind].sender != null;
                          var profileImage = Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipOval(
                              child: Container(
                                width: kToolbarHeight,
                                color: Theme.of(context).cardColor,
                                child: isSend
                                    ? (Provider.of<ProfileData>(context)
                                                    .cUserProfile
                                                    ?.image ??
                                                '') !=
                                            ""
                                        ? CachedNetworkImage(
                                            imageUrl: Provider.of<ProfileData>(
                                                    context)
                                                .cUserProfile!
                                                .image!,
                                          )
                                        : null
                                    : null,
                              ),
                            ),
                          );
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: isSend
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [
                                isSend ? profileImage : Container(),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: const Radius.circular(12),
                                      bottomRight: const Radius.circular(12),
                                      topLeft: Radius.circular(isSend ? 10 : 0),
                                      topRight:
                                          Radius.circular(isSend ? 0 : 10),
                                    ),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.all(10),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withAlpha(40),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            textString,
                                            textAlign:
                                                regexp.hasMatch(textString)
                                                    ? TextAlign.right
                                                    : TextAlign.left,
                                            textDirection:
                                                regexp.hasMatch(textString)
                                                    ? TextDirection.rtl
                                                    : TextDirection.ltr,
                                            style: TextStyle(
                                              fontSize: fontDelta + 13,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(
                                                  timeago.format(
                                                    DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            allMassages[ind]
                                                                .date),
                                                    locale: 'fa',
                                                  ),
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontSize: fontDelta + 12,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                !isSend ? profileImage : Container(),
                              ],
                            ),
                          );
                        },
                        itemCount: allMassages.length,
                      ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  // color: Colors.black12,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: AppBar().preferredSize.height,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          onSubmitted: (_) {
                            sendTextMassage();
                          },
                          controller: msgctrl,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            hintText: "پیام",
                            border: InputBorder.none,
                            //  OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(20),
                            //   ),
                            //   borderSide: BorderSide(
                            //     color: Theme.of(context).hintColor,
                            //     width: 0.5,
                            //   ),
                            // ),
                            focusedBorder: InputBorder.none,
                            //  OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(20),
                            //   ),
                            //   borderSide: BorderSide(
                            //     color: Theme.of(context).hintColor,
                            //     width: 0.5,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: IconButton(
                            icon: const Icon(
                              CupertinoIcons.share,
                            ),
                            onPressed: () {
                              sendTextMassage();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
