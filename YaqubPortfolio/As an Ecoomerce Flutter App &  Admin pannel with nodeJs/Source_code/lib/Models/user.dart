

import 'dart:convert';

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? address;
  final String? type;
  final String? token;
  final List<dynamic>? cart;

  User({
     this.id,
     this.name,
     this.email,
     this.password,
     this.address,
     this.type,
     this.token,
     this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
              (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}


// class User {
//   String? id;
//   String? name;
//   String? email;
//   String? password;
//   String? address;
//   String? type;
//   String? token;
//   // List<dynamic>? cart;
//
//   User({this.id,
//     this.name,
//     this.email,
//     this.password,
//     this.address,
//     this.type,
//     this.token,
//     //  this.cart
//   });
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     name = json['name'];
//     email = json['email'];
//     password = json['password'];
//     address = json['address'];
//     type = json['type'];
//     token = json['token'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['address'] = this.address;
//     data['type'] = this.type;
//     data['token'] = this.token;
//     return data;
//   }
//
//   User copyWith({
//     String? id,
//     String? name,
//     String? email,
//     String? password,
//     String? address,
//     String? type,
//     String? token,
//     List<dynamic>? cart,
//   }) {
//     return User(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       address: address ?? this.address,
//       type: type ?? this.type,
//       token: token ?? this.token,
//       //cart: cart ?? this.cart,
//     );
//   }
// }