import 'package:flutter/foundation.dart';
import 'package:novintaxidriver/backend/api_endpoints.dart';
import '../models/chat_massage_model.dart';

import '../backend/api.dart';

class MessageData with ChangeNotifier {
  void updater(authData) {
    if (authData.isAuthenticated) {
      initializeMessageData();
    } else {
      clearMessageData();
    }
  }

  initializeMessageData() async {
    await getSupportMessages();
    _isInitialized = true;
  }

  clearMessageData() {
    _supportMessageList = [];
    _isInitialized = true;
  }

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  List<AppChatMassage> _supportMessageList = [];
  List<AppChatMassage> get supportMessageList => _supportMessageList;

  Future<void> getSupportMessages() async {
    var messagesData = await AppAPI().getWithoutPaginate(urlPath: EndPoints.support);
    _supportMessageList = [];
    for (var element in messagesData) {
      var newPostType = AppChatMassage.fromMap(element);
      _supportMessageList.add(newPostType);
    }
    notifyListeners();
  }

  Future<void> addSupportMessage(AppChatMassage newMessage) async {
    await AppAPI().create(EndPoints.support, newMessage.toMap(), null);
    await getSupportMessages();
  }
}
