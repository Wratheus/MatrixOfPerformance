import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_stateful_button/stateful_button_controller.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_stateful_button/template_button.dart';

import '../../../core/constants/constants.dart';



class StatefulButton extends StatefulWidget {
  const StatefulButton(
      {super.key, required this.child,
        this.onTap,
        this.onHover,
        this.color = Colors.white,
        this.gradient,
        this.border,
        this.width,
        this.height,
        this.borderRadius = BorderRadius.zero,
        this.margin = EdgeInsets.zero,
        this.padding = EdgeInsets.zero,
        this.boxShadow = const [],
        this.canRequestFocus = true,
        this.disable = false,
        required this.controller});

  final TemplateButton child;
  final Function()? onTap;
  final Function(BuildContext context)? onHover;
  final Color color;
  final BoxBorder? border;
  final Gradient? gradient;
  final BorderRadius borderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final List<BoxShadow> boxShadow;
  final bool canRequestFocus;
  final bool disable;
  final ButtonController controller;

  @override
  State<StatefulButton> createState() => _StatefulButtonState();
}

class _StatefulButtonState extends State<StatefulButton> {

  @override
  initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  isDisable() {
    return widget.controller.isState(ButtonState.disable) || widget.controller.isState(ButtonState.loading);
  }

  @override
  Widget build(BuildContext context) {


    return Opacity(

        opacity: isDisable() ? .8 : 1,
        child: Container(
          margin: widget.margin,
          padding: widget.padding,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              boxShadow: widget.boxShadow,
              borderRadius: widget.borderRadius,
              border: widget.border),
          child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                  color: widget.color,
                  gradient: widget.gradient,
                  borderRadius: widget.borderRadius),
              child: InkWell(
                onHover: (_) => widget.onHover,
                canRequestFocus: widget.canRequestFocus,
                onTap: isDisable()
                    ? null
                    : widget.onTap,
                borderRadius: widget.borderRadius,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                        opacity: widget.controller.isState(ButtonState.loading) ? 0 : 1,
                        child: widget.child as Widget),
                    widget.controller.isState(ButtonState.loading) ?
                    const Positioned(
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: MyColors.mainBeige,
                              strokeWidth: 1,
                            ),
                          ),
                        )) : Container(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
