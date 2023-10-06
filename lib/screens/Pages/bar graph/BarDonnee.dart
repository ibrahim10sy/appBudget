import 'BarUnique.dart';

class BarDonnee{
  final double Janvier;
  final double Fevrier;
  final double Mars;
  final double Avril;
  final double Mai;
  final double Juin;
  final double Juillet;
  final double Aout;
  final double Septembre;
  final double Octobre;
  final double Novembre;
  final double Decembre;
  BarDonnee({
    required this.Janvier,
    required this.Fevrier,
    required this.Mars,
    required this.Avril,
    required this.Mai,
    required this.Juin,
    required this.Juillet,
    required this.Aout,
    required this.Septembre,
    required this.Octobre,
    required this.Novembre,
    required this.Decembre,
});
  List<BarUnique> barDonnee=[];

  void initializeBarDonnee(){
    barDonnee=[
      BarUnique(x: 0, y: Janvier),
      BarUnique(x: 0, y: Fevrier),
      BarUnique(x: 0, y: Mars),
      BarUnique(x: 0, y: Avril),
      BarUnique(x: 0, y: Mai),
      BarUnique(x: 0, y: Juin),
      BarUnique(x: 0, y: Juillet),
      BarUnique(x: 0, y: Aout),
      BarUnique(x: 0, y: Septembre),
      BarUnique(x: 0, y: Octobre),
      BarUnique(x: 0, y: Novembre),
      BarUnique(x: 0, y: Decembre)

    ];
  }
}