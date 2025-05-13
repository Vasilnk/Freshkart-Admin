import 'package:flutter/material.dart';
import 'package:freshkart_admin/services/notification_services.dart';
import 'package:freshkart_admin/utils/colors.dart';
import 'package:freshkart_admin/widgets/appbar.dart';

class SendCommonNotificationScreen extends StatefulWidget {
  const SendCommonNotificationScreen({super.key});

  @override
  State<SendCommonNotificationScreen> createState() =>
      _SendCommonNotificationScreenState();
}

class _SendCommonNotificationScreenState
    extends State<SendCommonNotificationScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final notificationServices = NotificationServices();

  List<Map<String, dynamic>> notifications = [];

  getNotifications() async {
    final fetched = await notificationServices.getAllNotifications();
    setState(() {
      notifications = fetched;
    });
  }

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Notification'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notification History",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child:
                  notifications.isEmpty
                      ? const Center(child: Text('No notifications yet'))
                      : ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Container(
                              color: Colors.grey[200],
                              child: ListTile(
                                leading: Icon(
                                  Icons.notifications,
                                  color: AppColors.greenColor,
                                ),
                                title: Text(notification['title']),
                                subtitle: Text(notification['message']),
                                trailing: InkWell(
                                  child: Icon(Icons.delete_outline_outlined),
                                  onTap: () async {
                                    await notificationServices
                                        .deleteNotification(
                                          notification['title'],
                                          context,
                                        );
                                    getNotifications();
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
            const SizedBox(height: 30),
            const Text(
              "New Notification",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter title',
                labelText: 'Title',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter message',
                labelText: 'Message',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Send Notification'),
                onPressed: () {
                  notificationServices.addNotification(
                    title: titleController.text.trim(),
                    message: messageController.text.trim(),
                    context: context,
                  );
                  titleController.clear();
                  messageController.clear();
                  getNotifications();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greenColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
