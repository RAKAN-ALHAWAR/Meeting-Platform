import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting/Config/config.dart';
import 'package:meeting/Ui/Screen/Meeting/AllMeetings/controller/controller.dart';
import 'package:uni_links/uni_links.dart';

import '../../Ui/Screen/Root/controller/controller.dart';

class DeepLinkServiceX {
  static final DeepLinkServiceX _instance = DeepLinkServiceX._internal();
  static StreamSubscription? _sub;

  DeepLinkServiceX._internal();

  /// Singleton instance to ensure only one instance of DeepLinkService is used.
  factory DeepLinkServiceX() {
    return _instance;
  }

  /// Initializes the deep link service and starts listening for links.
  static Future<void> init() async {
    try {
      // Handle initial link when the app is opened via a deep link
      final initialLink = await getInitialUri();
      if (initialLink != null) {
        _handleUri(initialLink);
      }

      // Listen for links while the app is running
      _sub = uriLinkStream.listen(
        (Uri? uri) {
          if (uri != null) {
            _handleUri(uri);
          }
        },
        onError: (err) {
          print('Error listening to deep link: $err');
        },
      );
    } catch (e) {
      print('Error initializing deep link: $e');
    }
  }

  /// Cancel stream subscription (optional, on dispose)
  static Future<void> dispose() async {
    await _sub?.cancel();
  }

  /// Handle incoming URIs
  static void _handleUri(Uri uri) {
    final host = uri.host;
    String path = (uri.path[uri.path.length - 1] == '/'
            ? uri.path.substring(0, uri.path.length - 1)
            : uri.path)
        .toLowerCase()
        .trim();

    if (host.isNotEmpty) {
      if (Get.find<RootController>().app.isLogin.isFalse) {
        Get.toNamed(RouteNameX.login);
        return;
      }
      // Handle dynamic meeting-details path (e.g., /meeting-details/1)
      if (path.startsWith('/meeting-details')) {
        final segments = path.split('/');
        if (segments.length > 2 && segments[2].isNotEmpty) {
          // Extract meeting ID (e.g., 283)
          final meetingId = segments[2];
          Get.toNamed(RouteNameX.meetingDetails, arguments: meetingId);
          return;
        } else {
          path = '/meetings';
        }
      } else if (path.startsWith('/suggestion-view')) {
        final segments = path.split('/');
        if (segments.length > 2 && segments[2].isNotEmpty) {
          // Extract suggestions ID (e.g., 1)
          final suggestionId = segments[2];
          Get.toNamed(RouteNameX.suggestionDetails, arguments: suggestionId);
          return;
        } else {
          path = '/suggestions';
        }
      }
      switch (path) {
        case '':
          Get.toNamed(RouteNameX.root);
          break;
        case '/meetings':
        case '/meetings-list':
        case '/all-meetings-list':
          Get.toNamed(RouteNameX.root);
          Get.find<RootController>().indexPageSelected.value = 1;
          break;
        case '/recurring-mettings':
          Get.offAndToNamed(RouteNameX.root);
          Get.find<RootController>().indexPageSelected.value = 1;
          Get.find<AllMeetingsController>().selectedTag.value = 1;
          break;
        case '/delegations':
          Get.toNamed(RouteNameX.root);
          Get.find<RootController>().indexPageSelected.value = 2;
          break;
        case '/profile':
        case '/settings':
          Get.toNamed(RouteNameX.root);
          Get.find<RootController>().indexPageSelected.value = 3;
          break;
        case '/signature':
          Get.toNamed(RouteNameX.signatures);
          break;
        case '/automatic-reparation':
          Get.toNamed(RouteNameX.automaticAttendances);
          break;
        case '/notifications':
          Get.toNamed(RouteNameX.notificationsSettings);
          break;
        case '/suggestions':
          Get.toNamed(RouteNameX.mySuggestions);
          break;
        default:
          Get.toNamed(RouteNameX.root);
          break;
      }
    }
  }
}
