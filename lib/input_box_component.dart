import 'package:flutter/material.dart';
import 'package:simple_text_form_field/text_component.dart';

class InputBoxComponent extends StatelessWidget {
  final String? label;
  final EdgeInsets edgeInsets;
  final String? childText;
  final Widget? children;
  final Widget? childrenSizeBox;
  final GestureTapCallback? onTap;
  final bool allowClear;
  final String? errorMessage;
  final IconData? icon;
  final bool isRequired;
  final bool? editable;
  final Function()? clearOnTab;

  const InputBoxComponent({
    Key? key,
    this.label,
    this.edgeInsets = const EdgeInsets.all(0),
    this.childText,
    this.onTap,
    this.children,
    this.childrenSizeBox,
    this.allowClear = false,
    this.clearOnTab,
    this.errorMessage,
    this.isRequired = false,
    this.icon,
    this.editable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: label != null,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: (isRequired == true)
                    ? Row(
                  children: [
                    TextComponent(
                      text: label ?? '-',
                      muted: true,
                    ),
                    const TextComponent(
                      text: "*",
                      muted: true,
                      color: Colors.red,
                    ),
                  ],
                )
                    : TextComponent(
                  text: label ?? '-',
                  muted: true,
                ),
              ),
              const Padding(padding: EdgeInsets.all(2)),
            ],
          ),
        ),
        Visibility(
          visible: children == null,
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: errorMessage != null
                        ? Border.all(color: Colors.red.shade700, width: .8)
                        : Border.all(color: Colors.black, width: .1),
                  ),
                  padding: childrenSizeBox != null
                      ? null
                      : const EdgeInsets.only(left: 10, right: 10),
                  child: childrenSizeBox ??
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: onTap,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextComponent(
                                  text: childText ?? '',
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: allowClear,
                            child:  Container(
                              width: 20,
                              height: 30,
                              child: InkWell(
                                onTap: clearOnTab,
                                child: const Icon(
                                  Icons.clear,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !allowClear && icon != null,
                            child: Container(
                              width: 20,
                              height: 30,
                              child: InkWell(
                                onTap: onTap,
                                child: Icon(
                                  icon,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                ),
              ),
              Visibility(
                visible: errorMessage != null,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 8,
                    left: 12,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextComponent(
                      text: errorMessage ?? "",
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: children != null,
          child: Column(
            children: [
              children ?? Container(),
              Visibility(
                visible: errorMessage != null,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 8,
                    left: 12,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextComponent(
                      text: errorMessage ?? "",
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(padding: edgeInsets),
      ],
    );
  }
}