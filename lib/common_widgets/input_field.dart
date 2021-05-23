import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscure;
  final bool enable;
  final bool textAlignCenter;
  final int maxLines;
  final focusNode;
  final bool collapsed;
  final Color fillColor;

  InputField({
    this.focusNode,
    this.hint,
    this.icon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.enable = true,
    this.textAlignCenter = false,
    this.maxLines,
    this.collapsed = false,
    this.fillColor = const Color(0xffF2F2F2),
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode ?? null,
      maxLines: widget.maxLines == null ? 1 : 3,
      enabled: widget.enable,
      controller: widget.controller,
      textAlign:
          widget.textAlignCenter == true ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        fontSize: 14,
        color: const Color(0xff000000),
        fontWeight: FontWeight.w300,
      ),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscure ? obscure : widget.obscure,
      decoration: InputDecoration(
        isCollapsed: widget.collapsed,
        contentPadding: widget.collapsed == true ? EdgeInsets.all(8) : null,
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w300,
        ),
        filled: true,
        fillColor: widget.fillColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.width * 0.5,
          maxWidth: MediaQuery.of(context).size.width * 0.5,
        ),
        prefixIcon: widget.icon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        widget.icon,
                        color: IconTheme.of(context).color,
                      ),
                    ),
                  ),
                ),
              )
            : null,
        suffixIcon: !widget.obscure
            ? null
            : IconButton(
                icon: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                  color: IconTheme.of(context).color,
                ),
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
              ),
      ),
    );
  }
}
