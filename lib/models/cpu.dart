
class CPU{
  final String name, core_count, core_clock, boost_clock, tdp,
        integrated_graphics;
  final double price_usd;

  CPU({
    required this.name,
    required this.price_usd,
    required this.core_count,
    required this.core_clock,
    required this.boost_clock,
    required this.tdp,
    required this.integrated_graphics,
  });

  factory CPU.fromJson(Map<String, dynamic> json){
    return CPU(
      name: json['name'],
      price_usd: json['price_usd'],
      core_count: json['core_count'],
      core_clock: json['core_clock'],
      boost_clock: json['boost_clock'],
      tdp: json['tdp'],
      integrated_graphics: json['integrated_graphics'],

    );
  }

}