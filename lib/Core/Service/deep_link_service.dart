import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkServiceX {
  static StreamSubscription? _sub;

  /// Initialize deep link listening (call this in main/init)
  static Future<void> init() async {
    try {
      // Listen for incoming links
      _sub = uriLinkStream.listen(
            (Uri? uri) {
          if (uri != null) {
            _handleUri(uri);
          }
        },
        onError: (err) {
          print('Error receiving deep link: $err');
        },
      );

      // Check for initial link (if app was launched via a link)
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        _handleUri(initialUri);
      }
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
    final path = uri.path;

    if (host == 'meeting.edialoguec.sa') {
      switch (path) {
        case '/':
        case '':
          Get.toNamed('/homePage');
          break;
        case '/meetings':
          Get.toNamed('/meetingsPage');
          break;
        case '/delegations':
          Get.toNamed('/delegationsPage');
          break;
        default:
          Get.toNamed('/notFoundPage');
          break;
      }
    }
  }
}