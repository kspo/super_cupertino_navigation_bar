class UserList {
  List<Users>? users;
  int? total;
  int? skip;
  int? limit;

  UserList({this.users, this.total, this.skip, this.limit});

  UserList.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}

class Users {
  dynamic id;
  dynamic firstName;
  dynamic lastName;
  dynamic maidenName;
  dynamic age;
  dynamic gender;
  dynamic email;
  dynamic phone;
  dynamic username;
  dynamic password;
  dynamic birthDate;
  dynamic image;
  dynamic bloodGroup;
  dynamic height;
  dynamic weight;
  dynamic eyeColor;
  Hair? hair;
  dynamic domain;
  dynamic ip;
  Address? address;
  dynamic macAddress;
  dynamic university;
  Bank? bank;
  Company? company;
  dynamic ein;
  dynamic ssn;
  dynamic userAgent;

  Users(
      {this.id,
      this.firstName,
      this.lastName,
      this.maidenName,
      this.age,
      this.gender,
      this.email,
      this.phone,
      this.username,
      this.password,
      this.birthDate,
      this.image,
      this.bloodGroup,
      this.height,
      this.weight,
      this.eyeColor,
      this.hair,
      this.domain,
      this.ip,
      this.address,
      this.macAddress,
      this.university,
      this.bank,
      this.company,
      this.ein,
      this.ssn,
      this.userAgent});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    maidenName = json['maidenName'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    password = json['password'];
    birthDate = json['birthDate'];
    image = json['image'];
    bloodGroup = json['bloodGroup'];
    height = json['height'];
    weight = json['weight'];
    eyeColor = json['eyeColor'];
    hair = json['hair'] != null ? Hair.fromJson(json['hair']) : null;
    domain = json['domain'];
    ip = json['ip'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    macAddress = json['macAddress'];
    university = json['university'];
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    ein = json['ein'];
    ssn = json['ssn'];
    userAgent = json['userAgent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['maidenName'] = maidenName;
    data['age'] = age;
    data['gender'] = gender;
    data['email'] = email;
    data['phone'] = phone;
    data['username'] = username;
    data['password'] = password;
    data['birthDate'] = birthDate;
    data['image'] = image;
    data['bloodGroup'] = bloodGroup;
    data['height'] = height;
    data['weight'] = weight;
    data['eyeColor'] = eyeColor;
    if (hair != null) {
      data['hair'] = hair!.toJson();
    }
    data['domain'] = domain;
    data['ip'] = ip;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['macAddress'] = macAddress;
    data['university'] = university;
    if (bank != null) {
      data['bank'] = bank!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['ein'] = ein;
    data['ssn'] = ssn;
    data['userAgent'] = userAgent;
    return data;
  }
}

class Hair {
  String? color;
  String? type;

  Hair({this.color, this.type});

  Hair.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['type'] = type;
    return data;
  }
}

class Address {
  String? address;
  String? city;
  Coordinates? coordinates;
  String? postalCode;
  String? state;

  Address(
      {this.address, this.city, this.coordinates, this.postalCode, this.state});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
    postalCode = json['postalCode'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    data['postalCode'] = postalCode;
    data['state'] = state;
    return data;
  }
}

class Coordinates {
  double? lat;
  double? lng;

  Coordinates({this.lat, this.lng});

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Bank {
  String? cardExpire;
  String? cardNumber;
  String? cardType;
  String? currency;
  String? iban;

  Bank(
      {this.cardExpire,
      this.cardNumber,
      this.cardType,
      this.currency,
      this.iban});

  Bank.fromJson(Map<String, dynamic> json) {
    cardExpire = json['cardExpire'];
    cardNumber = json['cardNumber'];
    cardType = json['cardType'];
    currency = json['currency'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardExpire'] = cardExpire;
    data['cardNumber'] = cardNumber;
    data['cardType'] = cardType;
    data['currency'] = currency;
    data['iban'] = iban;
    return data;
  }
}

class Company {
  Address? address;
  String? department;
  String? name;
  String? title;

  Company({this.address, this.department, this.name, this.title});

  Company.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    department = json['department'];
    name = json['name'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['department'] = department;
    data['name'] = name;
    data['title'] = title;
    return data;
  }
}
