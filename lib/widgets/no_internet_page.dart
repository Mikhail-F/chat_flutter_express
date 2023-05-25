import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  final VoidCallback reloadPage;
  const NoInternetPage({
    Key? key,
    required this.reloadPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "НЕТ ИНТЕРНЕТА",
            ),
            const SizedBox(height: 32),
            const Text(
              "Проверьте WiFi, мобильный интернет или\nперезапустите приложение",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: reloadPage, child: const Text("Обновить"))
          ],
        ),
      ),
    );
  }
}
