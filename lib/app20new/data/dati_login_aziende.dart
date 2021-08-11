class DatiLoginAziende {
  String cc = '';
  String cf = '';


  DatiLoginAziende({
    required this.cc,
    required this.cf,

  });
  DatiLoginAziende.fromMap(Map<String, dynamic> loginMap) {
    cc = loginMap['cc'];
    cf = loginMap['cf'];

  }
  Map<String, dynamic> toMap() {
    return {
      'cc': cc,
      'cf': cf,

    };
  }

  @override
  String toString() {
    return 'DatiLogin{ cc : $cc, cf : $cf}';
  }
}
