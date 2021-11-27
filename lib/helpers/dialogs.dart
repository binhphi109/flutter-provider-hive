import 'package:flutter/cupertino.dart';

showConfirmDialog(
  context, {
  title,
  content,
  confirmButtonText,
  cancelButtonText,
  onConfirm,
  onCancel,
}) {
  showCupertinoDialog(
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: Text(title ?? 'Please Confirm'),
          content: Text(content ?? 'Are you sure?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
              child: Text(confirmButtonText ?? 'Yes'),
              isDefaultAction: true,
              isDestructiveAction: true,
            ),
            CupertinoDialogAction(
              onPressed: () {
                if (onCancel != null) onCancel();
                Navigator.pop(context);
              },
              child: Text(cancelButtonText ?? 'No'),
              isDefaultAction: false,
              isDestructiveAction: false,
            )
          ],
        );
      });
}

showCustomDialog(
  context, {
  title,
  child,
  confirmButtonText,
  cancelButtonText,
  onConfirm,
}) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext ctx) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: child,
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: Text(confirmButtonText ?? 'Yes'),
            isDefaultAction: true,
            isDestructiveAction: true,
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(cancelButtonText ?? 'No'),
            isDefaultAction: false,
            isDestructiveAction: false,
          )
        ],
      );
    },
  );
}

showAlertDialog(
  context, {
  title,
  child,
  confirmButtonText,
  cancelButtonText,
  onConfirm,
}) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext ctx) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: child,
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              if (onConfirm != null) onConfirm();
              Navigator.pop(context);
            },
            child: Text(confirmButtonText ?? 'OK'),
            isDefaultAction: true,
          ),
        ],
      );
    },
  );
}
