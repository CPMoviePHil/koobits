import 'package:flutter/material.dart';

import '../enumeration/enumerations.dart';

import 'utils.dart';

class DialogHelper {

  late final BuildContext _context;

  DialogHelper.init ({
    required BuildContext context,
  }) {
    _context = context;
  }

  void dismissDialog() {
    Navigator.of(_context).pop();
  }

  Future<void> appShowDialog ({
    required DialogType type,
    bool dismissible = true,
    String? message,
    MessageType? messageType,
  }) async {
    Widget _dialog;
    switch (type) {
      case DialogType.message:
        _dialog = _MessageDialog(
          message: message!,
          messageType: messageType!,
        );
        break;
      case DialogType.loading:
      default:
        _dialog = const _LoadingDialog();
        break;
    }
    await showDialog(
      barrierDismissible: dismissible,
      context: _context,
      builder: (BuildContext context) => _dialog,
    );
  }
}

class _MessageDialog extends StatelessWidget {

  final String message;
  final MessageType messageType;

  const _MessageDialog ({
    Key? key,
    required this.message,
    required this.messageType,
  }) : super (key: key,);

  Icon _messageIcon ({
    required BuildContext context,
  }) {
    switch (messageType) {
      case MessageType.error:
        return WidgetsHelper.appIcon(
          icon: Icons.error,
          size: WidgetSize.extremeLarge,
          iconColor: Theme.of(context).errorColor,
        );
      case MessageType.succeed:
        return WidgetsHelper.appIcon(
          icon: Icons.check_circle_outline,
          size: WidgetSize.extremeLarge,
          iconColor: Theme.of(context).colorScheme.secondary,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _messageIcon(
            context: context,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: WidgetsHelper.appText(
              text: message,
              align: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingDialog extends StatelessWidget{

  const _LoadingDialog({Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SimpleDialog(
        key: key,
        elevation: 0,
        backgroundColor: Colors.transparent,
        children: <Widget>[
          Center(
            child: Column(
              children: const <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}