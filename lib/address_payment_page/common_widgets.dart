import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

commonPhoneNumberWidget(
  BuildContext context,
  TextEditingController phone,
) {
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    height: 80,
    child: InternationalPhoneNumberInput(
      selectorConfig: SelectorConfig(
          trailingSpace: false, selectorType: PhoneInputSelectorType.DROPDOWN),
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: TextStyle(color: HexColor("#175244")),
      initialValue: number,
      textFieldController: phone,
      inputDecoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
        labelText: 'Phone Number',
        labelStyle: TextStyle(
          color: HexColor("#175244"),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor("#175244"),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor("#175244"),
            width: 2,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      onInputChanged: (PhoneNumber value) {},
    ),
  );
}

commonTextIPWidget(
    BuildContext context, TextEditingController txtcontroler, String lbltxt) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).size.height * 0.005,
    ),
    child: TextFormField(
      style: const TextStyle(color: Colors.black), //<-- SEE HERE
      controller: txtcontroler,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
        labelText: lbltxt,
        labelStyle: TextStyle(
          color: HexColor("#175244"),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor("#175244"),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor("#175244"),
            width: 2,
          ),
        ),
      ),
    ),
  );
}
