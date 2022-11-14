import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'payment.dart';
import 'boxes.dart';
import 'model/cart_model.dart';
import 'model/user_model.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  getuserkey() async {
    final keypref = await SharedPreferences.getInstance();
    userkey = keypref.getInt('userkey')!;
    setState(() {});
    print(userkey);
    return userkey;
  }

  @override
  var userkey = 0;
  void initState() {
    getuserkey();
    super.initState();
  }

  addAddress(context) {
    final fname = TextEditingController();
    final phone = TextEditingController();
    final hno = TextEditingController();
    final roadname = TextEditingController();
    final city = TextEditingController();
    final state = TextEditingController();
    final pincode = TextEditingController();
    final box = Boxes.getUserData();
    final data = box.values.toList().cast<UserData>();

    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Text(
                      "New Address",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#175244"),
                      ),
                    )),
                //full name
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: fname,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Full Name',
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
                ),
                //phone number
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 80,
                  child: InternationalPhoneNumberInput(
                    selectorConfig: SelectorConfig(
                        trailingSpace: false,
                        selectorType: PhoneInputSelectorType.DROPDOWN),
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
                ),
                //house no, building name
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: hno,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'House No., Building Name',
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
                ),
                //road name,area,colony
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: roadname,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Road Name, Area, Colony',
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
                ),
                //city
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: city,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'City',
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
                ),
                //state
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: state,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'State',
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
                ),
                //pincode
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: pincode,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Pincode',
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
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  // height: 100,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      var xresult = {
                        'name': fname.text,
                        'phno': phone.text,
                        'hno': hno.text,
                        'area': roadname.text,
                        'city': city.text,
                        'state': state.text,
                        'pincode': pincode.text,
                      };

                      data[0].address.add(xresult);
                      box.put(userkey, data[userkey]);

                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                      backgroundColor: HexColor("#036635"),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  editAddress(context, index) {
    final box = Boxes.getUserData();
    final data = box.values.toList().cast<UserData>();
    final fname = TextEditingController(text: data[0].address[index]['name']);
    final phone = TextEditingController(text: data[0].address[index]['phno']);
    final hno = TextEditingController(text: data[0].address[index]['hno']);
    final roadname =
        TextEditingController(text: data[0].address[index]['area']);
    final city = TextEditingController(text: data[0].address[index]['city']);
    final state = TextEditingController(text: data[0].address[index]['state']);
    final pincode =
        TextEditingController(text: data[0].address[index]['pincode']);

    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Text(
                      "Edit Address",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#175244"),
                      ),
                    )),

                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: fname,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Full Name',
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
                ),
                //phone number
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 80,
                  child: InternationalPhoneNumberInput(
                    selectorConfig: SelectorConfig(
                        trailingSpace: false,
                        selectorType: PhoneInputSelectorType.DROPDOWN),
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
                ),
                //house no, building name
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: hno,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'House No., Building Name',
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
                ),
                //road name,area,colony
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: roadname,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Road Name, Area, Colony',
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
                ),
                //city
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: city,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'City',
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
                ),
                //state
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: state,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'State',
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
                ),
                //pincode
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black), //<-- SEE HERE
                    controller: pincode,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Pincode',
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
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  // height: 100,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      // data[userkey].address[index]=result;

                      var xresult = {
                        'name': fname.text,
                        'phno': phone.text,
                        'hno': hno.text,
                        'area': roadname.text,
                        'city': city.text,
                        'state': state.text,
                        'pincode': pincode.text,
                      };
                      data[0].address[index] = xresult;
                      box.put(userkey, data[userkey]);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                      backgroundColor: HexColor("#036635"),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var selectedVal;
  setSelectedVal(var val) {
    setState(() {
      selectedVal = val;
    });
  }

  late String k = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        backgroundColor: Colors.white,
        foregroundColor: HexColor("#175244"),
      ),
      body: ValueListenableBuilder<Box<UserData>>(
          valueListenable: Boxes.getUserData().listenable(),
          builder: (context, box, _) {
            final data = box.values.toList().cast<UserData>();
            if (data[userkey].address.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No saved address'),
                    Container(
                      //height: MediaQuery.of(context).size.height * 0.80,
                      child: TextButton(
                          onPressed: () {
                            addAddress(context);
                          },
                          child: Text('Add a new address')),
                    )
                  ],
                ),
              );
            } else {
              //int? len = int?.parse(data[0].address.length! / 7);

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data[0].address.length,
                      itemBuilder: (context, index) {
                        String addressSendToOtherPage = data[0].address[index]
                                ['name'] +
                            ", " +
                            data[0].address[index]['hno'] +
                            ", " +
                            data[0].address[index]['area'] +
                            ", " +
                            data[0].address[index]['city'] +
                            ", " +
                            data[0].address[index]['state'] +
                            ", " +
                            data[0].address[index]['pincode'];

                        return Column(
                          children: [
                            //radio
                            RadioListTile(
                              title: Text(addressSendToOtherPage),
                              subtitle: Text("Phone Number: " +
                                  data[0].address[index]['phno']),
                              value: data[0].address[index],
                              groupValue: selectedVal,
                              onChanged: (value) async {
                                setState(() {
                                  setSelectedVal(value);
                                  k = value.toString();
                                  print(k);
                                });
                                final addressSharedPred =
                                    await SharedPreferences.getInstance();
                                await addressSharedPred.setString(
                                    'selectedAddress', addressSendToOtherPage);
                              },
                              selected: selectedVal == data[0].address[index],
                            ),
                            Container(
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        editAddress(context, index);
                                      },
                                      child: Text('Edit')),
                                  TextButton(
                                      onPressed: () {
                                        data[0].address.removeAt(index);
                                        setState(() {});
                                      },
                                      child: Text('Remove'))
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        addAddress(context);
                      },
                      child: Text('Add a new address')),
                ],
              );
            }
          }),
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(8.0),
          child: ValueListenableBuilder<Box<CartData>>(
              valueListenable: Boxes.getCartData().listenable(),
              builder: (context, box, _) {
                final data = box.values.toList().cast<CartData>();
                late double result = 0;
                for (int index = 0; index < data.length; index++) {
                  result = result +
                      double.parse(data[index].price) * data[index].qty;
                }
                return Row(
                  children: [
                    Text(
                      "Total: \$${result.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        k.isEmpty
                            ? Dialog(
                                child: Text("Select Address"),
                              )
                            : Get.to(PaymentPage(),
                                transition: Transition.rightToLeft);
                      },
                      child: Text("Pay"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(HexColor("#036635"))),
                    ),
                  ],
                );
              })),
    );
  }
}