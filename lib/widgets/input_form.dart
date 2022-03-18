import 'package:flutter/material.dart';
import 'package:food_shop/utils/controller.dart';
import 'package:food_shop/utils/validator.dart';

abstract class InputForm {
  /// E-mail input form.
  static final TextFormField email = TextFormField(
    controller: Controller.email,
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
      labelText: 'E-mail',
      border: OutlineInputBorder(),
    ),
  );

  /// Password input form.
  static final TextFormField password = TextFormField(
    controller: Controller.password,
    keyboardType: TextInputType.visiblePassword,
    decoration: const InputDecoration(
      labelText: 'Password',
      border: OutlineInputBorder(),
    ),
  );

  /// Full Name input form.
  static final TextFormField fullName = TextFormField(
    controller: Controller.fullName,
    keyboardType: TextInputType.name,
    // maxLength: 40,
    validator: (value) => Validator.isEmpty(value),
    decoration: const InputDecoration(
      labelText: "Full Name",
      border: OutlineInputBorder(),
    ),
  );

  /// Phone input form.
  static final TextFormField phone = TextFormField(
    controller: Controller.phone,
    keyboardType: TextInputType.phone,
    decoration: const InputDecoration(
      labelText: 'Phone',
      border: OutlineInputBorder(),
    ),
  );

  /// Address input form.
  static final TextFormField address = TextFormField(
    controller: Controller.address,
    keyboardType: TextInputType.streetAddress,
    decoration: const InputDecoration(
      labelText: 'Address',
      border: OutlineInputBorder(),
    ),
  );
}