class DatiLoginClienti {
  int id = 1;
  String cc = '';
  String g = '';
  String m = '';
  String a = '';

  DatiLoginClienti({
    required this.cc,
    required this.g,
    required this.m,
    required this.a,
  });
  DatiLoginClienti.fromMap(Map<String, dynamic> loginMap) {
    cc = loginMap['cc'];
    g = loginMap['g'];
    m = loginMap['m'];
    a = loginMap['a'];
  }
  Map<String, dynamic> toMap() {
    return {
      'cc': cc,
      'g': g,
      'm': m,
      'a': a,
    };
  }

  @override
  String toString() {
    return 'DatiLogin{ cc : $cc, g : $g, m : $m, a : $a,}';
  }
}
