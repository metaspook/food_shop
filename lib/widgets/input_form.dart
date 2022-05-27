import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/utils/validator.dart';

abstract class InputForm {
  InputForm._();

  /// E-mail input form.
  static TextFormField email([String? previousText]) => TextFormField(
        controller: XController.email,
        keyboardType: TextInputType.emailAddress,
        validator: (value) => Validator.email(value),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          hintText: previousText,
          labelText: 'E-mail',
          border: const OutlineInputBorder(),
        ),
      );

  /// Password input form.
  static TextFormField password(
          [String? previousText, bool obscureText = true]) =>
      TextFormField(
        obscureText: obscureText,
        controller: XController.password,
        keyboardType: TextInputType.visiblePassword,
        validator: (value) => Validator.password(value),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          hintText: previousText,
          labelText: 'Password',
          border: const OutlineInputBorder(),
        ),
      );

  /// Full Name input form.
  static TextFormField fullName([String? previousText]) => TextFormField(
        controller: XController.fullName,
        keyboardType: TextInputType.name,
        // maxLength: 40,
        validator: (value) => Validator.fullName(value),

        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          hintText: previousText,
          labelText: "Full Name",
          border: const OutlineInputBorder(),
        ),
      );

  /// Phone input form.
  static TextFormField phone([String? previousText]) => TextFormField(
        controller: XController.phone,
        keyboardType: TextInputType.phone,
        validator: (value) => Validator.phone(value),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          hintText: previousText,
          labelText: 'Phone',
          border: const OutlineInputBorder(),
        ),
      );

  /// Address input form.
  static TextFormField address([String? previousText]) => TextFormField(
        controller: XController.address,
        keyboardType: TextInputType.streetAddress,
        validator: (value) => Validator.nullOrEmpty(value),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          hintText: previousText,
          labelText: 'Address',
          border: const OutlineInputBorder(),
        ),
      );

  /// Price input form.
  static TextFormField price(int index, num previousPrice) {
    // static TextFormField price({int index = 0, num previousPrice = 0}) {
    return TextFormField(
      controller: ProductsController.updatePrices[index],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
        hintText: '$previousPrice',
        labelText: 'Price',
        border: const OutlineInputBorder(),
      ),
    );
  }

  /// Stock input form.
  static TextFormField stock(int index, int previousStock) {
    // static TextFormField stock({int index = 0, int previousStock = 0}) {
    return TextFormField(
      controller: ProductsController.updateStocks[index],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
        hintText: '$previousStock',
        labelText: 'Stock',
        border: const OutlineInputBorder(),
      ),
    );
  }
}
