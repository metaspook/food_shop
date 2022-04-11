import 'package:flutter/material.dart';
import 'package:food_shop/controllers/controllers.dart';
import 'package:food_shop/utils/controllers.dart';
import 'package:food_shop/utils/validator.dart';

abstract class InputForm {
  InputForm._();

  /// E-mail input form.
  static final TextFormField email = TextFormField(
    controller: Controllers.email,
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
      labelText: 'E-mail',
      border: OutlineInputBorder(),
    ),
  );

  /// Password input form.
  static final TextFormField password = TextFormField(
    controller: Controllers.password,
    keyboardType: TextInputType.visiblePassword,
    decoration: const InputDecoration(
      labelText: 'Password',
      border: OutlineInputBorder(),
    ),
  );

  /// Full Name input form.
  static final TextFormField fullName = TextFormField(
    controller: Controllers.fullName,
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
    controller: Controllers.phone,
    keyboardType: TextInputType.phone,
    decoration: const InputDecoration(
      labelText: 'Phone',
      border: OutlineInputBorder(),
    ),
  );

  /// Address input form.
  static final TextFormField address = TextFormField(
    controller: Controllers.address,
    keyboardType: TextInputType.streetAddress,
    decoration: const InputDecoration(
      labelText: 'Address',
      border: OutlineInputBorder(),
    ),
  );

  /// Price input form.
  static TextFormField price(int index, num previousPrice) {
    // static TextFormField price({int index = 0, num previousPrice = 0}) {
    return TextFormField(
      controller: ProductsController.updatePrices[index],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
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
        hintText: '$previousStock',
        labelText: 'Stock',
        border: const OutlineInputBorder(),
      ),
    );
  }
}
