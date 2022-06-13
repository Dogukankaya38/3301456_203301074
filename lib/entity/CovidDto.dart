class CovidDto {
  String confvalue;
  String recvalue;
  String deaths;
  String lastupdate;

  CovidDto({
    required this.confvalue,
    required this.recvalue,
    required this.deaths,
    required this.lastupdate
  });

  factory CovidDto.fromJson(Map < dynamic, dynamic > json) {
    return CovidDto(
        confvalue: json['world_total']['total_cases'],
        recvalue: json['world_total']['total_recovered'],
        deaths: json['world_total']['total_deaths'],
        lastupdate: json['world_total']['statistic_taken_at']);
  }
}