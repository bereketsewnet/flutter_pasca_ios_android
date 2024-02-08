import 'package:flutter/widgets.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  void initialize() {
    WidgetsBinding.instance?.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('App Resumed');
        break;
      case AppLifecycleState.inactive:
        print('App Inactive');
        break;
      case AppLifecycleState.paused:
        print('App Paused');
        break;
      case AppLifecycleState.detached:
        print('App Detached');
        break;
      case AppLifecycleState.hidden:
        print('App hidden');
        break;
    }
  }
}
