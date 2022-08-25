import 'package:flutter/material.dart';
import 'package:simple_text_form_field/input_box_component.dart';
import 'package:simple_text_form_field/simple_contants.dart';

class SimpleTextFormFieldDateController {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _con = TextEditingController();
  late bool _required;
  late InputDatetimeType _type;
  late BuildContext _context;
  late Function(VoidCallback fn) setState;
  FocusNode? focusNode = FocusNode();

  DateTime? _date;
  TimeOfDay? _time;
  String? _errorMessage;

  Function()? onChanged;

  set value(dynamic val) {
    setState(() {
      if (_type == InputDatetimeType.date) {
        _date = val;
      } else {
        _time = val;
      }
    });
  }

  dynamic get value {
    try{
      if (_type == InputDatetimeType.date) {
        return _date??"";
      } else {
        return _time??"";
      }
    }catch(ex){
      return _date??"";
    }
  }

  String? _validator(String v, {FormFieldValidator<String>? otherValidator}) {
    if (_required && (v.isEmpty)) {
      return 'The field is required';
    }
    if (((_type == InputDatetimeType.date && _date == null) ||
        (_type == InputDatetimeType.time && _time == null))) {
      setState(() {
        FocusScope.of(_context).requestFocus(focusNode);
      });
      return 'The field is required';
    }
    return null;
  }

  bool get isValid {
    bool? valid = _key.currentState?.validate();
    if (valid == null) {
      return true;
    }
    if (valid == false) {
      FocusScope.of(_context).requestFocus(focusNode);
    }
    return valid;
  }

  void _onTab(bool editable) async {
    if (!editable) return;
    if (_type == InputDatetimeType.date) {
      final DateTime? picked = await showDatePicker(
        context: _context,
        initialDate: _date ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(3000),
      );
      if (picked != null && _date != picked) {
        setState(() {
          _date = picked;
          _con.text = SimpleConstants.dateToString(_date, format: "dd/MM/yyyy")!;
        });
      }
    } else {
      final TimeOfDay? picked = await showTimePicker(
        context: _context,
        initialTime: _time ?? TimeOfDay.now(),
      );
      if (picked != null && _time != picked) {
        setState(() {
          _time = picked;
          _con.text = _time!.format(_context);
        });
      }
    }
    if (onChanged != null) {
      onChanged!();
    }
  }

  void _init(
    Function(VoidCallback fn) setStateX,
    BuildContext contextX,
    bool requiredX,
    InputDatetimeType typeX,
  ) {
    setState = setStateX;
    _context = contextX;
    _required = requiredX;
    _type = typeX;
  }

  void _clearOnTab() {
    setState(() {
      _date = null;
      _time = null;
      _con.clear();
    });
  }
}

enum InputDatetimeType {
  date,
  time,
}

class SimpleTextFormFieldDate extends StatefulWidget {
  final bool isRequired;
  final String? label;
  final bool editable;
  final InputDatetimeType type;
  final String? placeHolder;
  final double? marginBottom;
  final FormFieldValidator<String>? validator;
  final String? prefixText;
  final Radius? borderRadius;
  final bool visibility;
  final EdgeInsets edgeInsets;
  final SimpleTextFormFieldDateController? controller;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmited;
  final double fontsize;
  final Color? hintColor;
  final Color? fillColor;
  final double errorTextSize;
  final InputDecoration? customInputDecoration;

  const SimpleTextFormFieldDate(
      {Key? key,
      @required this.controller,
      this.isRequired = false,
      this.label,
      this.editable = true,
      this.type = InputDatetimeType.date,
      this.placeHolder,
      this.marginBottom,
      this.validator,
      this.onEditingComplete,
      this.prefixText,
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
  State<SimpleTextFormFieldDate> createState() =>
      _SimpleTextFormFieldDateState();
}

class _SimpleTextFormFieldDateState extends State<SimpleTextFormFieldDate> {
  @override
  void initState() {
    widget.controller!._init(setState, context, widget.isRequired, widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller!._required = widget.isRequired;
    widget.controller!._type = widget.type;
    widget.controller!._context = context;

    final decoration = InputDecoration(
      filled: true,
      fillColor: widget.fillColor ??
          Colors.black.withOpacity(widget.editable ? .01 : .05),
      hintText: widget.placeHolder ?? (widget.type==InputDatetimeType.date?"dd/mm/yyyy":"hh:mm"),
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
      suffixIcon: widget.controller!._con.text.isNotEmpty?InkWell(
        onTap:()=> widget.controller!._clearOnTab(),
        child: Icon(
          Icons.clear,
          color: Colors.black.withOpacity(0.6),
          size: 14,
        ),
      ): widget.type == InputDatetimeType.date
          ? Icon(
              Icons.calendar_month,
              color: Colors.black.withOpacity(0.6),
              size: 14,
            )
          : Icon(
              Icons.access_time_outlined,
              color: Colors.black.withOpacity(0.6),
              size: 14,
            ),
    );

    var textFormField = TextFormField(
      onTap: () => widget.controller!._onTab(widget.editable),
      focusNode: widget.controller!.focusNode,
      onFieldSubmitted: widget.onFieldSubmited,
      style: TextStyle(
        color: Colors.black,
        fontSize: widget.fontsize,
      ),
      controller: widget.controller!._con,
      validator: (v) =>
          widget.controller!._validator(v!, otherValidator: widget.validator),
      autocorrect: false,
      enableSuggestions: false,
      readOnly: !widget.editable,

      onEditingComplete: widget.onEditingComplete,

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
            child:textFormField,
          ),
        ),
      ),
    );
  }
}
