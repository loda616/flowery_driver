import 'package:dio/dio.dart';

class NotificationService {
  final Dio _dio = Dio();
  final String serverKey = 'YOUR_SERVER_KEY';

  Future<void> sendNotification(String token, String title, String body) async {
    final data = {
      "to": token,
      "notification": {
        "title": title,
        "body": body,
      },
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "status": "done"
      }
    };

    try {
      await _dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "key=$serverKey",
          },
        ),
      );
    } catch (e) {
      print("Failed to send notification: $e");
    }
  }
}
