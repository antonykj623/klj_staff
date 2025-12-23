import 'package:flutter/material.dart';

class AppUtils{


static void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

 static  void hideLoader(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }


  static void showAlert(BuildContext context,String message,)
  {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("KLJ Cafe"),
          content: Text(message),
          actions: [

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );

  }



static Future<bool?> showYesNoDialog(
    BuildContext context,
    String title,
    String message,
    ) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("No"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Yes"),
        ),
      ],
    ),
  );
}

static  showSingleButtonAlert(
    BuildContext context,
    String title,
    String message,
    ) {
   showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [

        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}



}