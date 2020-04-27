import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class NFCReader extends StatefulWidget {
  NFCReader({this.onMessage});
  final void Function(NDEFMessage) onMessage;

  @override
  _NFCReaderState createState() => _NFCReaderState();
}

class _NFCReaderState extends State<NFCReader> {
  StreamSubscription<NDEFMessage> _stream;

  @override
  void initState() {
    super.initState();

    _stream = NFC.readNDEF(throwOnUserCancel: false).listen(widget.onMessage);
  }

  @override
  void dispose() {
    _stream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(width: 0.0, height: 0.0);
  }
}
