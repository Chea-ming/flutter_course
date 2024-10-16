void main() {
  Distance d1 = Distance.kms(3.4);
  Distance d2 = Distance.meters(1000);
  print((d1 + d2).kms);
}

class Distance {
  late double _ms;

  Distance.cms(double cms) : _ms = cms / 100;

  Distance.meters(double meters) : _ms = meters;

  Distance.kms(double kms) : _ms = kms * 1000;

  Distance operator +(Distance other) {
    return Distance.meters(_ms + other._ms);
  }

  double get meters => _ms;
  double get kms => _ms / 1000;
  double get cms => _ms * 100;
}
