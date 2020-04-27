import 'package:flutter/material.dart';

class LabelledInput extends StatelessWidget {
  LabelledInput(
      {this.labelText,
      this.keyboardType,
      this.validator,
      this.onSaved,
      this.hintText,
      this.controller,
      this.disabled = false});
  final String labelText;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final void Function(String) onSaved;
  final bool disabled;
  final String hintText;
  final TextEditingController controller;

  OutlineInputBorder border({Color color = const Color(0xFF4A5568)}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        style: BorderStyle.solid,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labelText,
          style: TextStyle(
            fontSize: 15.0,
            color: Color(0xFFA0AEC0),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: controller,
          enabled: !this.disabled,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) =>
              FocusScope.of(context).nextFocus(), // move focus to next
          validator: validator,
          onSaved: onSaved,
          keyboardType: keyboardType,
          cursorColor: Color(0xFFE2E8F0),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(top: 2.0, right: 2.0, left: 15.0, bottom: 2.0),
            enabledBorder: border(),
            disabledBorder: border(),
            focusedBorder: border(),
            errorBorder: border(color: Colors.red[400]),
            focusedErrorBorder: border(color: Colors.red[400]),
            fillColor: this.disabled ? Color(0x664A5568) : Color(0xFF2D3748),
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0x77A0AEC0)),
            filled: true,
            errorStyle: TextStyle(color: Colors.red[400], fontSize: 14.0),
          ),
          style: TextStyle(
            color: Color(0xFFE2E8F0),
          ),
        )
      ],
    );
  }
}
