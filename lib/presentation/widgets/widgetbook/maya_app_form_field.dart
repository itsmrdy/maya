import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/themes.dart';

class MayaAppFormField extends StatefulWidget {
  const MayaAppFormField({
    super.key,
    required this.labelText,
    this.counterText = "",
    this.isPasswordField = false,
    this.onChanged,
    this.maxLength = 32,
    this.prefixText,
    this.textInputType,
    this.inputFormatter,
    this.controller,
  });

  final String labelText;
  final String counterText;
  final bool isPasswordField;
  final void Function(String?)? onChanged;
  final int maxLength;
  final String? prefixText;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? controller;

  @override
  State<MayaAppFormField> createState() => _MayaAppFormFieldState();
}

class _MayaAppFormFieldState extends State<MayaAppFormField> {
  bool _isObscureText = true;
  bool _hasBorderError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.defaultColor,
        border:
            _hasBorderError ? Border.all(color: Colors.red, width: 2) : null,
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPasswordField ? _isObscureText : false,
        keyboardType: widget.textInputType,
        inputFormatters: widget.inputFormatter,
        onChanged: (String? data) {
          if (_hasBorderError) {
            if (mounted) {
              setState(() {
                _hasBorderError = false;
              });
            }
          }
          widget.onChanged!(data);
        },
        maxLength: widget.maxLength,
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (mounted) {
              setState(() {
                _hasBorderError = true;
              });
            }
            return null;
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: AppTheme.sm, top: AppTheme.sm),
          counterText: widget.counterText,
          label: Text(
            widget.labelText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppTheme.sm,
              color: AppTheme.greyColor,
            ),
          ),
          border: InputBorder.none,
          prefixText: widget.prefixText,
          suffixIcon: widget.isPasswordField
              ? Padding(
                  padding: const EdgeInsets.only(right: AppTheme.xs),
                  child: IconButton(
                    onPressed: () {
                      if (mounted) {
                        setState(() => _isObscureText = !_isObscureText);
                      }
                    },
                    icon: _prefixIconForPassword(),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _prefixIconForPassword() {
    return _isObscureText
        ? FaIcon(FontAwesomeIcons.eyeSlash,
            color: Colors.black, size: AppTheme.medium)
        : FaIcon(FontAwesomeIcons.eye,
            color: Colors.black, size: AppTheme.medium);
  }
}
