import 'package:flutter/material.dart';
import 'package:simple_text_form_field/input_box_component.dart';
import 'package:simple_text_form_field/text_component.dart';
import 'package:simple_text_form_field/text_ink_well_component.dart';
class SimpleTextFormFieldDropDownController<T> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late Function(VoidCallback fn) setState;

  T? _value;
  Function(T? value)? onChanged;
  late bool _required = false;

  dynamic get value {
    return _value;
  }

  void _rootOnChanged(e) {
    print("Masuk sini ${e.toString()}");
  setState((){
    _value = e;
    if (onChanged != null) {
      onChanged!(e);
    }
  });

  }

  String? _validator(v) {
    if (_required && v == null) {
      return 'The field is required';
    }
    return null;
  }

  bool get isValid {
    bool? valid = _key.currentState?.validate();
    if (valid == null) {
      return true;
    }
    return valid;
  }

  void _init(Function(VoidCallback fn) setStateX, bool requiredX) {
    setState = setStateX;
    _required = requiredX;
  }
}

class SimpleTextFormFieldDropDown<T> extends StatefulWidget {
  final String? label;
  final double? marginBottom;
  final bool required;
  final bool editable;
  final Radius? borderRadius;
  final List<T>listItem;
  final String Function(T) ?valueItem;
  final String hintText;

  final SimpleTextFormFieldDropDownController controller;
  final Color ?fillColor;

  const SimpleTextFormFieldDropDown({
    Key? key,
    this.label,
    this.marginBottom,
    this.editable = true,
    this.fillColor,
    this.borderRadius,
    this.hintText = "Select One",
    required this.listItem,
    required this.controller,
    this.valueItem,
    this.required = false,
  }) : super(key: key);

  @override
  State<SimpleTextFormFieldDropDown<T>> createState() => _SimpleTextFormFieldDropDownState<T>();
}

class _SimpleTextFormFieldDropDownState<T> extends State<SimpleTextFormFieldDropDown<T>> {
  @override
  void initState() {
    widget.controller._init(
      setState,
      widget.required,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      filled: true,
      hintText: widget.hintText,
      hintStyle: const TextStyle(fontSize: 12),
      contentPadding: const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
      fillColor: widget.fillColor ?? Colors.black.withOpacity(.01),
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(.1)),
        borderRadius:
        BorderRadius.all(widget.borderRadius ?? const Radius.circular(4.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(.1)),
        borderRadius:
        BorderRadius.all(widget.borderRadius ?? const Radius.circular(4.0)),
      ),
      prefixStyle: TextStyle(
        color: Colors.white.withOpacity(0.6),
      ),
      suffixIconConstraints: const BoxConstraints(
        minHeight: 30,
        minWidth: 30,
      ),
    );

    return InputBoxComponent(
      label: widget.label,
      isRequired: widget.required,
      children: widget.editable
          ? Form(
        key: widget.controller._key,
        child: DropdownButtonFormField<T>(
          decoration: decoration,
          isExpanded: true,
          focusColor: Colors.transparent,
          validator: widget.controller._validator,
          value: widget.controller._value,
          items: widget.listItem
              .map((e) => DropdownMenuItem<T>(
            value: e,
            child: TextComponent(text:widget.valueItem!(e)),
          ))
              .toList(),
          onChanged: widget.controller._rootOnChanged,
          style: TextStyle(
            color: Colors.black.withOpacity(.7),
            fontSize:12,
          ),
          dropdownColor: Colors.white,
        ),
      )
          : null,
    );
  }
}

