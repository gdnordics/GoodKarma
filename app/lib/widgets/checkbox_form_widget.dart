import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {required Widget title,
      required FormFieldSetter<bool> onSaved,
      required FormFieldValidator<bool> onValidate,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: onValidate,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) =>  Text(
                          state.errorText ?? "error",
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}