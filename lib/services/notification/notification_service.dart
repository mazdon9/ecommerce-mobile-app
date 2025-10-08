import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

/// Top-level function to handle background messages
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print("Message data: ${message.data}");
    print("Message notification: ${message.notification?.title}");
  }
}

@LazySingleton()
class NotificationService {
  NotificationService(this._logger);

  final AppLogger _logger;

  static const AndroidNotificationChannel _androidChannel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String? _fcmToken;

  /// Get the current FCM token
  String? get fcmToken => _fcmToken;

  /// Initialize the notification service
  Future<void> initialize() async {
    try {
      // Initialize local notifications
      await _initializeLocalNotifications();

      // Request permissions
      await _requestPermissions();

      // Get FCM token
      await _getFCMToken();

      // Configure FCM
      await _configureFCM();

      _logger.i('NotificationService initialized successfully');
    } catch (e, stackTrace) {
      _logger.e('Error initializing NotificationService', error: e, stackTrace: stackTrace);
    }
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _localNotifications.initialize(initializationSettings, onDidReceiveNotificationResponse: _handleNotificationTap);

    // Create notification channel for Android
    if (Platform.isAndroid) {
      await _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(
        _androidChannel,
      );
    }
  }

  /// Request notification permissions
  Future<bool> _requestPermissions() async {
    // Request FCM permissions
    final NotificationSettings fcmSettings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    bool fcmGranted =
        fcmSettings.authorizationStatus == AuthorizationStatus.authorized || fcmSettings.authorizationStatus == AuthorizationStatus.provisional;

    // Request local notification permissions for iOS
    bool localGranted = true;
    if (Platform.isIOS) {
      localGranted =
          await _localNotifications.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }

    final bool permissionsGranted = fcmGranted && localGranted;

    _logger.i('Notification permissions granted: $permissionsGranted');
    return permissionsGranted;
  }

  /// Get FCM token
  Future<void> _getFCMToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      _logger.i('FCM Token: $_fcmToken');

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((String token) {
        _fcmToken = token;
        _logger.i('FCM Token refreshed: $token');
        // TODO: Send new token to your backend server
      });
    } catch (e, stackTrace) {
      _logger.e('Error getting FCM token', error: e, stackTrace: stackTrace);
    }
  }

  /// Configure FCM message handling
  Future<void> _configureFCM() async {
    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle messages when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Handle initial message if app was terminated
    final RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleInitialMessage(initialMessage);
    }
  }

  /// Handle foreground messages
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    _logger.i('Received foreground message: ${message.messageId}');

    // Show local notification for foreground messages
    await _showLocalNotification(
      title: message.notification?.title ?? 'New Message',
      body: message.notification?.body ?? 'You have a new message',
      payload: jsonEncode(message.data),
    );
  }

  /// Handle messages when app is opened from notification
  void _handleMessageOpenedApp(RemoteMessage message) {
    _logger.i('Message opened app: ${message.messageId}');
    _handleNotificationAction(message.data);
  }

  /// Handle initial message when app was terminated
  void _handleInitialMessage(RemoteMessage message) {
    _logger.i('App opened from terminated state: ${message.messageId}');
    _handleNotificationAction(message.data);
  }

  /// Handle notification tap
  void _handleNotificationTap(NotificationResponse response) {
    _logger.i('Notification tapped: ${response.id}');

    if (response.payload != null) {
      try {
        final Map<String, dynamic> data = jsonDecode(response.payload!);
        _handleNotificationAction(data);
      } catch (e) {
        _logger.e('Error parsing notification payload', error: e);
      }
    }
  }

  /// Handle notification actions based on data
  void _handleNotificationAction(Map<String, dynamic> data) {
    _logger.i('Handling notification action with data: $data');

    // TODO: Implement your notification action logic here
    // For example:
    // - Navigate to specific screen
    // - Update app state
    // - Perform specific actions based on notification type

    final String? type = data['type'];
    final String? targetScreen = data['target_screen'];

    switch (type) {
      case 'order_update':
        // Navigate to orders screen
        _logger.i('Navigating to orders screen');
        break;
      case 'promotion':
        // Navigate to promotions or specific product
        _logger.i('Navigating to promotion');
        break;
      case 'message':
        // Navigate to messages or chat
        _logger.i('Navigating to messages');
        break;
      default:
        _logger.i('Unknown notification type: $type');
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification({required String title, required String body, String? payload}) async {
    try {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        icon: '@mipmap/ic_launcher',
      );

      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);

      const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

      await _localNotifications.show(DateTime.now().millisecondsSinceEpoch.remainder(100000), title, body, notificationDetails, payload: payload);

      _logger.i('Local notification shown: $title');
    } catch (e, stackTrace) {
      _logger.e('Error showing local notification', error: e, stackTrace: stackTrace);
    }
  }

  // /// Show notification with custom data
  // Future<void> showNotification({required String title, required String description, Map<String, dynamic>? data}) async {
  //   await _showLocalNotification(title: title, body: description, payload: data != null ? jsonEncode(data) : null);
  // }

  // /// Subscribe to a topic
  // Future<void> subscribeToTopic(String topic) async {
  //   try {
  //     await _firebaseMessaging.subscribeToTopic(topic);
  //     _logger.i('Subscribed to topic: $topic');
  //   } catch (e, stackTrace) {
  //     _logger.e('Error subscribing to topic: $topic', error: e, stackTrace: stackTrace);
  //   }
  // }

  // /// Unsubscribe from a topic
  // Future<void> unsubscribeFromTopic(String topic) async {
  //   try {
  //     await _firebaseMessaging.unsubscribeFromTopic(topic);
  //     _logger.i('Unsubscribed from topic: $topic');
  //   } catch (e, stackTrace) {
  //     _logger.e('Error unsubscribing from topic: $topic', error: e, stackTrace: stackTrace);
  //   }
  // }

  // /// Check if notifications are enabled
  // Future<bool> areNotificationsEnabled() async {
  //   final NotificationSettings settings = await _firebaseMessaging.getNotificationSettings();
  //   return settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional;
  // }

  // /// Open notification settings
  // Future<void> openNotificationSettings() async {
  //   if (Platform.isAndroid) {
  //     await _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  //   }
  // }
}
