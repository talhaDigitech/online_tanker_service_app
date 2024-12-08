class TankerRequest {
  final String address;
  final int gallons;
  final double tankerCharges;
  final double distanceFare;
  final double totalCharges;
  final String hydrantLocation;
  final DateTime requestTime;

  TankerRequest({
    required this.address,
    required this.gallons,
    required this.tankerCharges,
    required this.distanceFare,
    required this.totalCharges,
    required this.hydrantLocation,
    required this.requestTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'gallons': gallons,
      'tankerCharges': tankerCharges,
      'distanceFare': distanceFare,
      'totalCharges': totalCharges,
      'hydrantLocation': hydrantLocation,
      'requestTime': requestTime.toIso8601String(),
    };
  }

  factory TankerRequest.fromJson(Map<String, dynamic> json) {
    return TankerRequest(
      address: json['address'],
      gallons: json['gallons'],
      tankerCharges: json['tankerCharges'],
      distanceFare: json['distanceFare'],
      totalCharges: json['totalCharges'],
      hydrantLocation: json['hydrantLocation'],
      requestTime: DateTime.parse(json['requestTime']),
    );
  }
} 