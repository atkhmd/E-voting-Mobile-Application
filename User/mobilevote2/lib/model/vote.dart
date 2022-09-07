class Vote {
  final int voteVal;
  final String candName;
  final String colorVal;
  Vote(this.voteVal, this.candName, this.colorVal);

  Vote.fromMap(Map<String, dynamic> map)
      : assert(map['voteVal'] != null),
        assert(map['candName'] != null),
        assert(map['colorVal'] != null),
        voteVal = map['voteVal'],
        candName = map['candName'],
        colorVal = map['caolorVal'];

  @override
  String toString() => "Results<$voteVal:$candName:$colorVal>";
}
