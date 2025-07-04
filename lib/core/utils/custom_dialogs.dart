import 'package:estoregpt/widgets/alert_message.dart';
import 'package:flutter/material.dart';

void showAlertMessage(
    {required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onTap}) {
  showDialog(
    context: context,
    builder: (context) =>
        AlertMessage(title: title, message: message, onTap: onTap),
  );
}

void showErrorMessage(
    {required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onTap}) {
  showDialog(
    context: context,
    builder: (context) => AlertMessage(
      title: title,
      message: message,
      onTap: onTap,
      alertImage: "assets/images/error_image.png",
    ),
  );
}

// void showDialogLoader(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) => WillPopScope(
//       onWillPop: () async => false,
//       child: Center(
//         child: AlertDialog(
//           backgroundColor: Colors.transparent,
//           surfaceTintColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           elevation: 0,
//           content: Center(
//             child: Container(
//               height: 80,
//               width: 80,
//               decoration: const BoxDecoration(color: Colors),
//               child: const CircularLoader(),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

void showDialogLoader(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          content: Center(
            child: Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    ),
  );
}
