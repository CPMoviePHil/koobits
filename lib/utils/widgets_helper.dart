import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../enumeration/enumerations.dart';

typedef TextFormFieldOnChange = Function(String str);

class WidgetsHelper {

  static void outFocus ({
    required BuildContext context
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static BorderSide appBorder ({
    required BuildContext context,
    double width = 0.5,
    Color? color,
  }) {
    color ??= Theme.of(context).highlightColor;
    return BorderSide(
      width: width,
      color: color,
    );
  }

  static ElevatedButton appButton ({
    required BuildContext context,
    required String buttonLabel,
    VoidCallback? onPressed,
    Color? color,
    Color? fontColor,
    WidgetSize? size,
    FontWeight? fontWeight,
    EdgeInsetsGeometry? padding,
  }) {
    color ??= Theme.of(context).primaryColor;
    return ElevatedButton(
      child: appText(
        text: buttonLabel,
        size: size,
        fontWeight: fontWeight,
        fontColor: fontColor,
      ),
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(padding),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (color != null) {
              if (states.contains(MaterialState.pressed)) {
                return color;
              }
              else if (states.contains(MaterialState.disabled)) {
                return color;
              } else {
                return color;
              }
            } else {
              return Theme.of(context).primaryColor;
            }
          },
        ),
      ),
      /*style: ElevatedButton.styleFrom(
        primary: color,
        onSurface: color,
        padding: padding,
      ),*/
    );
  }

  static Icon appIcon ({
    required IconData icon,
    Color? iconColor,
    WidgetSize? size,
  }) {
    double _iconSize = _size(size: size);
    return Icon(
      icon,
      color: iconColor,
      size: _iconSize,
    );
  }

  static Widget appIconButton ({
    required BuildContext context,
    required Widget iconWidget,
    String? tooltip,
    Color? fontColor,
    VoidCallback? onTap,
  }) {
    fontColor ??= Theme.of(context).highlightColor;
    final Widget _iconButton = IconButton(
      onPressed: onTap,
      icon: iconWidget,
    );
    if (tooltip == null) {
      return _iconButton;
    } else {
      return Tooltip(
        textStyle: WidgetsHelper.appTextStyle(
          fontColor: fontColor,
        ),
        message: tooltip,
        child: _iconButton,
      );
    }
  }

  static Text appText ({
    required String? text,
    WidgetSize? size,
    TextStyle? style,
    Color? fontColor,
    FontWeight? fontWeight,
    TextAlign? align,
    double? lineSpacing,
    double? letterSpacing,
    TextDecoration? decoration,
    TextOverflow? overflow,
  }) {
    return Text(
      "$text",
      textAlign: align,
      overflow: overflow,
      style: style ?? appTextStyle(
        size: size,
        fontColor: fontColor,
        fontWeight: fontWeight,
        align: align,
        lineSpacing: lineSpacing,
        letterSpacing: letterSpacing,
        decoration: decoration,
      ),
    );
  }

  static SizedBox appSizedHeightBox ({
    required WidgetSize size,
  }) {
    double _height = _size(size: size);
    return SizedBox(height: _height,);
  }

  static SelectableText appSelectableText({
    required String? text,
    WidgetSize? size,
    TextStyle? style,
    Color? fontColor,
    TextAlign? align,
    double? lineSpacing,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return SelectableText(
      "$text",
      textAlign: align,
      style: style ?? appTextStyle(
        size: size,
        fontColor: fontColor,
        align: align,
        lineSpacing: lineSpacing,
        letterSpacing: letterSpacing,
        decoration: decoration,
      ),
    );
  }

  static TextStyle appTextStyle ({
    WidgetSize? size,
    Color? fontColor,
    TextAlign? align,
    double? lineSpacing,
    double? letterSpacing,
    TextDecoration? decoration,
    FontWeight? fontWeight,
  }) {
    double fontSize = _size(size: size);
    return TextStyle(
      color: fontColor,
      fontSize: fontSize,
      height: lineSpacing,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  static TextFormField appTextFormField ({
    bool enableSuggestions = false,
    bool obscure = false,
    required BuildContext context,
    TextFormFieldOnChange? onChange,
    TextEditingController? controller,
    WidgetSize? size,
    int? maxLines,
    Color? fontColor,
    Color? cursorColor,
    FontWeight? fontWeight,
    String? errorMessage,
    String? hintMessage,
    Icon? suffixIcon,
    VoidCallback? suffixIconPressed,
    InputDecoration? decoration,
    double borderWidth = 2,
    double radius = 0,
    Color? borderColor,
    Color? errorColor,
    List<TextInputFormatter>? inputFormatters,
  }) {
    fontColor ??= Theme.of(context).colorScheme.onPrimary;
    cursorColor ??= Theme.of(context).colorScheme.onPrimary;
    maxLines ??= 1;
    return TextFormField(
      style: appTextStyle(
        size: size,
        fontColor: fontColor,
        fontWeight: fontWeight,
      ),
      cursorColor: cursorColor,
      controller: controller,
      onChanged: onChange,
      obscureText: obscure,
      enableSuggestions: enableSuggestions,
      decoration: decoration ?? textFieldDecoration(
        context: context,
        hintMessage: hintMessage,
        errorMessage: errorMessage,
        suffixIcon: suffixIcon,
        suffixIconPressed: suffixIconPressed,
        borderWidth: borderWidth,
        radius: radius,
        borderColor: borderColor,
        errorColor: errorColor,
      ),
      maxLines: maxLines,
      inputFormatters: inputFormatters,
    );
  }

  static TextFormField appTextFormFieldReadOnly ({
    required BuildContext context,
    required InputDecoration decoration,
    required TextEditingController? controller,
    WidgetSize? size,
    int? maxLines,
    Color? fontColor,
  }) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      controller: controller,
      style: appTextStyle(
        size: size,
        fontColor: fontColor,
      ),
      enableSuggestions: false,
      readOnly: true,
      decoration: decoration,
    );
  }

  static InputDecoration textFieldDecoration ({
    required BuildContext context,
    String? errorMessage,
    String? hintMessage,
    Icon? suffixIcon,
    VoidCallback? suffixIconPressed,
    double borderWidth = 2,
    double radius = 0,
    Color? borderColor,
    Color? errorColor,
  }) {
    return InputDecoration(
      hintText: hintMessage,
      errorText: errorMessage,
      enabledBorder: _inputBorder(
        color: borderColor ?? Theme.of(context).colorScheme.onPrimary,
        borderWidth: borderWidth,
        radius: radius,
      ),
      focusedBorder: _inputBorder(
        color: borderColor ?? Theme.of(context).colorScheme.onPrimary,
        borderWidth: borderWidth,
        radius: radius,
      ),
      border: _inputBorder(
        color: borderColor ?? Theme.of(context).colorScheme.onPrimary,
        borderWidth: borderWidth,
        radius: radius,
      ),
      errorBorder: _inputBorder(
        color: errorColor ?? Theme.of(context).errorColor,
        borderWidth: borderWidth,
        radius: radius,
      ),
      suffixIcon: suffixIcon != null ? IconButton(
        onPressed: suffixIconPressed,
        icon: suffixIcon,
      ) : null,
    );
  }

  static InputBorder _inputBorder({
    required Color color,
    required double borderWidth,
    required double radius,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: color,
        width: borderWidth,
      ),
    );
  }

  static Icon passwordHiddenIcon ({
    required BuildContext context,
    required bool passwordShowed,
  }) {
    if (passwordShowed) {
      return WidgetsHelper.appIcon(
        icon: Icons.remove_red_eye_outlined,
        iconColor: Theme.of(context).colorScheme.primaryVariant,
      );
    } else {
      return WidgetsHelper.appIcon(
        icon: Icons.remove_red_eye,
        iconColor: Theme.of(context).colorScheme.primaryVariant,
      );
    };
  }

  static double _size ({
    required WidgetSize? size,
  }) {
    size ??= WidgetSize.normal;
    switch (size) {
      case WidgetSize.extremeLarge:
        return 35;
      case WidgetSize.large:
        return 25;
      case WidgetSize.small:
        return 16;
      case WidgetSize.extremeSmall:
        return 12;
      default :
        return 18;
    }
  }
}