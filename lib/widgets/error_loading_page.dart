import 'package:flutter/material.dart';

class ErrorLoadingPage extends StatelessWidget {
  final VoidCallback reloadPage;
  const ErrorLoadingPage({
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
          children: [
            const Text(
              "Упс ...\nчто то пошло не так",
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
