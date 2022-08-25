library simple_text_form_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_text_form_field/input_box_component.dart';
import 'package:simple_text_form_field/simple_contants.dart';

enum InputTextType {
  text,
  email,
  password,
  number,
  paragraf,
  money,
  phone,
  ktp
}

class SimpleTextFormFieldController extends ChangeNotifier {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _con = TextEditingController();
  Function(VoidCallback fn)? setState;

  bool _required = false;
  InputTextType _type = InputTextType.text;
  double? _moneyValue;
  bool _showPassword = false;

  ValueChanged<String>? onChanged;
  GestureTapCallback? onTap;
  FormFieldSetter<String>? onSaved;
  FocusNode focusNode = FocusNode();
  BuildContext? _context;
  int? _numberOfPhoneNumberLength;

  String? _validator(String v, {FormFieldValidator<String>? otherValidator}) {
    if (_required && (v.isEmpty)) {
      return 'The field is required';
    }
    if (_type == InputTextType.email) {
      final regex = RegExp(SimpleConstants.pattern);
      if ((v.isEmpty) || !regex.hasMatch(v)) {
        return 'Enter a valid email address';
      } else {
        return null;
      }
    }
    if (_type == InputTextType.phone) {
      if (v.length < _numberOfPhoneNumberLength! && v.isNotEmpty) {
        return 'Minimal ${_numberOfPhoneNumberLength!.toString()} digit';
      }
    }

    if (_type == InputTextType.ktp) {
      if (v.length < 16) return "Please input minimum 16 digits";
    }
    if (otherValidator != null) {
      return otherValidator(v);
    }
    return null;
  }

  void _onFocusChange(bool stateFocus) {
    if (stateFocus) {
      _con.text = _moneyValue == 0 ? "" : "${_moneyValue ?? ""}";
    } else {
      _moneyValue = double.tryParse(_con.text);
      _con.text = SimpleConstants.currencyFormat(_moneyValue ?? 0);
    }
  }

  void _init(Function(VoidCallback fn) setStateX) {
    setState = setStateX;
  }

  bool get isValid {
    bool? valid = _key.currentState?.validate();
    if (valid == null) {
      return true;
    }
    if (valid == false) {
      FocusScope.of(_context!).requestFocus(focusNode);
    }
    return valid;
  }

  dynamic get value {
    if (_type == InputTextType.number) {
      return num.tryParse(_con.text);
    } else if (_type == InputTextType.money) {
      return _moneyValue;
    } else {
      return _con.text;
    }
  }

  void clearFocus() {
    if (focusNode.hasPrimaryFocus) {
      focusNode.unfocus();
    }
  }

  void clearValue() {
    _con.clear();
  }

  set value(dynamic value) {
    if (_type == InputTextType.money) {
      _con.text =
          value == null ? "" : SimpleConstants.currencyFormat(value ?? 0);
      _moneyValue = value;
    } else {
      _con.text = value == null ? "" : "$value";
    }
  }

  @override
  void dispose() {
    _con.dispose();
    focusNode.dispose();
    super.dispose();
  }
}

class SimpleTextFormField extends StatefulWidget {
  final bool isRequired;
  final String? label;
  final bool editable;
  final InputTextType type;
  final String? placeHolder;
  final double? marginBottom;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final String? prefixText;
  final Radius? borderRadius;
  final bool visibility;
  final EdgeInsets edgeInsets;
  final SimpleTextFormFieldController? controller;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmited;
  final double fontsize;
  final int? maxLength;
  final Color? hintColor;
  final Color? fillColor;
  final double errorTextSize;
  final int maxDigitPhoneNumber;
  final InputDecoration? customInputDecoration;

  const SimpleTextFormField(
      {Key? key,
      @required this.controller,
      this.isRequired = false,
      this.label,
      this.editable = true,
      this.type = InputTextType.text,
      this.placeHolder,
      this.marginBottom,
      this.inputFormatters,
      this.validator,
      this.onEditingComplete,
      this.maxLength,
      this.prefixText,
      this.maxDigitPhoneNumber = 12,
      this.borderRadius,
      this.fontsize = 12,
      this.onFieldSubmited,
      this.edgeInsets = const EdgeInsets.all(0),
      this.visibility = true,
      this.fillColor,
      this.customInputDecoration,
      this.hintColor,
      this.errorTextSize = 10})
      : super(key: key);

  @override
  _SimpleTextFormFieldState createState() => _SimpleTextFormFieldState();
}

class _SimpleTextFormFieldState extends State<SimpleTextFormField> {
  @override
  void initState() {
    widget.controller!._init(setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller!._required = widget.isRequired;
    widget.controller!._type = widget.type;
    widget.controller!._context = context;
    widget.controller!._numberOfPhoneNumberLength = widget.maxDigitPhoneNumber;

    final decoration = InputDecoration(
      filled: true,
      fillColor: widget.fillColor ??
          Colors.black.withOpacity(widget.editable ? .01 : .05),
      hintText: widget.placeHolder,
      errorStyle: TextStyle(fontSize: widget.errorTextSize, height: 0.3),
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
      prefixText: widget.prefixText,
      prefixStyle: TextStyle(
        color: Colors.black.withOpacity(0.6),
      ),
      suffixIconConstraints: const BoxConstraints(
        minHeight: 30,
        minWidth: 30,
      ),
      suffixIcon: widget.type == InputTextType.password
          ? InkWell(
              splashColor: Colors.transparent,
              onTap: () => setState(() {
                widget.controller!._showPassword =
                    !widget.controller!._showPassword;
              }),
              child: Icon(
                widget.controller!._showPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black.withOpacity(0.6),
                size: 14,
              ),
            )
          : null,
    );

    var textFormField = TextFormField(
      maxLines: widget.type == InputTextType.paragraf ? 4 : 1,
      maxLength: ((widget.type == InputTextType.phone) ||
              (widget.type == InputTextType.ktp))
          ? widget.maxLength
          : null,
      onChanged: widget.controller!.onChanged,
      onSaved: widget.controller!.onSaved,
      onTap: widget.controller!.onTap,
      focusNode: widget.controller!.focusNode,
      onFieldSubmitted: widget.onFieldSubmited,
      style: TextStyle(
        color: Colors.black,
        fontSize: widget.fontsize,
      ),
      inputFormatters: (widget.type == InputTextType.number ||
              widget.type == InputTextType.money ||
              widget.type == InputTextType.phone ||
              widget.type == InputTextType.ktp)
          ? [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,10}')),
              ...(widget.inputFormatters ?? []),
            ]
          : null,
      controller: widget.controller!._con,
      validator: (v) =>
          widget.controller!._validator(v!, otherValidator: widget.validator),
      autocorrect: false,
      enableSuggestions: false,
      readOnly: !widget.editable,
      obscureText: widget.type == InputTextType.password
          ? !widget.controller!._showPassword
          : false,
      onEditingComplete: widget.onEditingComplete,
      keyboardType: (widget.type == InputTextType.number ||
              widget.type == InputTextType.money)
          ? TextInputType.number
          : null,
      decoration: widget.customInputDecoration ?? decoration,
    );

    return Visibility(
      visible: widget.visibility,
      child: Padding(
        padding: widget.edgeInsets,
        child: InputBoxComponent(
          label: widget.label,
          childText: widget.controller!._con.text,
          isRequired: widget.isRequired,
          children: Form(
            key: widget.controller!._key,
            child: widget.type == InputTextType.money
                ? Focus(
                    onFocusChange: widget.controller!._onFocusChange,
                    child: textFormField,
                  )
                : textFormField,
          ),
        ),
      ),
    );
  }
}
