import 'package:global_configuration/global_configuration.dart';
import 'package:icommerce/models/add_address_model.dart';
import 'package:icommerce/models/address_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:icommerce/models/status_model.dart';

class AddressApi {
  static var client = http.Client();

  static Future<AddressListModel> fetchAddressList(String userId) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    var response = await client.post(
        Uri.parse('${baseUrl}deliveryaddresslist/'),
        body: {'userid': userId});

    if (response.statusCode == 200) {
      return addressListModelFromJson(response.body);
    } else {
      return addressListModelFromJson(response.body);
    }
  }

  /*
  static Future<AddAddressModel> addAddress(
      String address,
      String addressType,
      String email,
      String isActive,
      String landmark,
      String name,
      String phoneOne,
      String phoneTwo,
      String pin,
      String userid) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    print(
        'user reg data: address: $address, addressType $addressType, email: $email, isActive: $isActive,'
        'landmark: $landmark, name: $name, phoneOne $phoneOne, phoneTwo: $phoneTwo, pin: $pin, userId: $userid');
//addrs:address
// addrtype:Home
// email:email
// IsActive:true
// landmark:landmark
// name:Sam32
// phno1:9876543213
// phno2:9876543201
// pin:1234567
// userid:9
    /*
    var response = await client.post(Uri.parse('${baseurl}addaddress/'), body: {
      'addrs': address,
      'addrtype': addressType,
      'email': email,
      'IsActive': isActive,
      'landmark': landmark,
      'name': name,
      'phno1': phoneOne,
      'phno2': phoneTwo,
      'pin': pin,
      'userid': userid
    });

     */

    var response = await client.post(Uri.parse('${baseUrl}addaddress/'), body: {
      'addrs': address,
      'addrtype': addressType,
      'email': email,
      'IsActive': isActive,
      'landmark': landmark,
      'name': name,
      'phno1': phoneOne,
      'phno2': phoneTwo,
      'pin': pin,
      'userid': userid
    });

    print('base url: ${baseUrl}addaddress/, response: ${response.statusCode}');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return addAddressModelFromJson(jsonString);
    } else {
      return addAddressModelFromJson(response.body);
    }
  }

   */

//
  static Future<AddressAddModel> addAddress(
      String address,
      String addressType,
      String email,
      String isActive,
      String landmark,
      String name,
      String phoneOne,
      String phoneTwo,
      String pin,
      String city,
      String state,
      String userid) async {

    var baseUrl = GlobalConfiguration().get('base_url');

    print(
        'user reg data: address: $address, addressType $addressType, email: $email, isActive: $isActive,'
            'landmark: $landmark, name: $name, phoneOne $phoneOne, phoneTwo: $phoneTwo, pin: $pin, city: $city, state: $state userId: $userid');


    //addrs:23 street
    // addrtype:Home
    // email:email
    // IsActive:true
    // landmark:landmark
    // name:Sam Smith
    // phno1:9876543213
    // phno2:9876543201
    // pin:1234567
    // userid:9
    var response = await client.post(Uri.parse('${baseUrl}adddeliveryaddress/'), body: {
      'addrs': address,
      'addrtype': addressType,
      'email': email,
      'IsActive': isActive,
      'landmark': landmark,
      'name': name,
      'phno1': phoneOne,
      'phno2': phoneTwo,
      'pin': pin,
      'city': city,
      'states': state,
      'userid': userid
    });

    print('base url: ${baseUrl}adddeliveryaddress/, response: ${response.statusCode}, response body: ${response.body}\n${response.request}');

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return addressAddModelFromJson(jsonString);
    }
    return addressAddModelFromJson(response.body);
  }

  static Future<AddressAddModel> editAddress(
      String address,
      String addressType,
      String email,
      String isActive,
      String landmark,
      String name,
      String phoneOne,
      String phoneTwo,
      String pin,
      String city,
      String state,
      String userid,
      String addressId) async {

    var baseUrl = GlobalConfiguration().get('base_url');

    print(
        'user reg data: address: $address, addressType $addressType, email: $email, isActive: $isActive,'
            'landmark: $landmark, name: $name, phoneOne $phoneOne, phoneTwo: $phoneTwo, pin: $pin, city: $city, state: $state userId: $userid, addressId: $addressId');


    //addrs:23 street
    // addrtype:Home
    // email:email
    // IsActive:true
    // landmark:landmark
    // name:Sam Smith
    // phno1:9876543213
    // phno2:9876543201
    // pin:1234567
    // userid:9
    var response = await client.post(Uri.parse('${baseUrl}updateaddress/'), body: {
      'addrs': address,
      'addrtype': addressType,
      'email': email,
      'IsActive': isActive,
      'landmark': landmark,
      'name': name,
      'phno1': phoneOne,
      'phno2': phoneTwo,
      'pin': pin,
      'city': city,
      'states': state,
      'userid': userid,
      'srno':addressId
    });

    print('base url: ${baseUrl}adddeliveryaddress/, response: ${response.statusCode}, response body: ${response.body}\n${response.request}');

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return addressAddModelFromJson(jsonString);
    }
    return addressAddModelFromJson(response.body);
  }


  static Future<StatusModel> deleteAddress(String addressId) async {
    var baseUrl = GlobalConfiguration().get('base_url');

    // prdid:4
    // userid:9
    // cartid:270920214612
    var response = await client.post(Uri.parse('${baseUrl}deletedeliveryaddress/'),
        body: {'idd': addressId});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return statusModelFromJson(jsonString);
    } else {
      return statusModelFromJson(response.body);
    }
  }
}
