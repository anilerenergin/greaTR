import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData whiteTheme = ThemeData(
    iconTheme: IconThemeData(color: Colors.black),
    brightness: Brightness.light,
    primaryColor: Color(0xFF9077d1),
    primaryColorDark: Color(0xFFf43d7f),
    primaryColorLight: Color(0xFF6ab5d1),
    cardColor: Color(0xFF0D253C),
    bottomAppBarColor: Color(0xFF7B8BB2),
    splashColor: Color(0xFFf38962),
    hintColor: Color(0xFF9077d1),
    backgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        labelStyle: TextStyle(color: Color(0xFF9077d1), fontSize: 24.0)),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.openSans(
          fontSize: 14, color: Color(0xFF0D253C), fontWeight: FontWeight.w400),
      bodyText2: GoogleFonts.inter(
          fontSize: 16, color: Color(0xFF0D253C), fontWeight: FontWeight.w600),
      headline1: GoogleFonts.openSans(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0D253C),
      ),
      headline2: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF0D253C),
      ),
      headline3: GoogleFonts.openSans(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline4: GoogleFonts.openSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      subtitle1: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Color(0xFF2D4379),
      ),
      subtitle2: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF2D4379),
      ),
    ));

List<String> onBoardingImages = [
  'images/onboard1.png',
  'images/onboard2.png',
  'images/onboard3.png',
];
List<String> onBoardingTexts = [
  'greaTR üyelerine özel iş fırsatlarını kaçırma, aldığın eğitimin maddi manevi karşılığını al',
  'greaTR üyeleri için özel olarak tasarlanmış olan sosyal ve profesyonel etkinliklere katılarak iş ağını genişlet, yetkinliklerini geliştir',
  'Yaşadığın şehir ve ülkeye özel topluluklara üye ol, etrafındaki insanlarla tanış ve vakit geçir',
];

List<String> homeSectionChipList = [
  'Ana Sayfa',
  'Etkinlikler',
  'İş Fırsatları'
];
TextStyle activeChip(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .bodyText1!
      .copyWith(color: Colors.purple.shade800, fontWeight: FontWeight.bold);
}

TextStyle inActiveChip(BuildContext context) {
  return Theme.of(context).textTheme.bodyText1!;
}

String lorem =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

List<String> countryList = [
  'Almanya',
  'Amerika Birleşik Devletleri',
  'Fransa',
  'Hollanda',
  'İngiltere',
  'İtalya',
  'Kanada',
  'Diğer'
];

List<String> majors = [
  "Sosyal Bilimler",
  "Sanat - Dizayn",
  "Tıp - Sağlık",
  "Mühendislik",
  "Mimarlık - İnşaat",
  "Medya",
  "İşletme",
  "Hukuk",
  "Ekonomi - Finans",
  "Eğitim",
  "Bilgisayar ve Bilişim Teknolojileri",
  "Uygulamalı ve kuramsal Bilimler",
  "Tarım - Veterinerlik",
];

Map<String, List<String>> cityList = {
  'Amerika Birleşik Devletleri': [
    'Chicago',
    'Boston',
    'New York',
    'Washington',
    'Los Angeles',
    'Rhode Islands',
    'Diğer',
  ],
  'Almanya': [
    'Aachen',
    'Berlin',
    'Heidelberg',
    'Karlsruhe',
    'Münih',
    'Würzburg',
    'Schweinfurt',
    'Bremen',
    'Nürnberg',
    'Diğer',
  ],
  'İngiltere': [
    'Manchester',
    'Londra',
    'Birmingham',
    'Bath',
    'Nottingham',
    'Durham',
        'Coventry',
    'Sheffield',
    'Oxford',
    'Westminster',
    'Diğer',
  ],
  "İtalya":[
    "Milano",
		"Roma",
		"Bologna",
		"Padova",
    'Diğer',
  ],
  'Hollanda': ['Amsterdam', 'Rotterdam', 'Maastricht','Diğer',],
  'Fransa': ['Paris', 'Lille', 'Strasbourg', 'Lyon', 'Montpellier', 'Toulouse','Diğer',],
  'Kanada': ['Montreal', 'Vancouver', 'Toronto','Diğer',]
};
Map<String, List<String>> universityList={
"Vancouver":[
  "University of British Columbia",
"Simon Fraser University" ,
"Capilano University" ,
"British Columbia Institute of Technology",
"Vancouver Community College",
"Emily Carr University of Art + Design",
"Kwantlen Polytechnic University",
"Langara College",
"Columbia College",
"Diğer"
],
"Toronto":[
  "University of Toronto",
"University of Waterloo",
"Ryerson University",
"York University",
"George Brown College",
"OCAD University",
"Diğer"
],
"Montreal":[
"McGill University",
"Concordia University",
"HEC Montréal",
"UQAM (Université du Québec à Montréal)",
"École Polytechnique de Montréal",
"Diğer"
],
"Roma":[
  "Universita di Roma Sapienza",
"Universita di Roma Tre",
"Universita degli Studi di Roma tor Vergata",
"Diğer"
],
"Padova":[
  "University of Padua",
  "Diğer"
],
"Milano":[
  "Universitâ Bocconi",
"Universita Cattolica",
"Nuova Accademia di Belle Arti",
"Istituto Europeo di Design IED",
"Politecnico di Milano",
"Vita-Salute San Raffaele University",
"Isituto Marangoni ",
"University of Milan",
"IULM University",
"Diğer"

],
"Bologna":[
  "Bologna Üniversitesi ",
"Johns Hopkins Üniversitesi",
"Accademia di Belle Arti Bologna",
"Conservatorio di Musica Giovan Battista Martini Bologna",
"Diğer"
],
"Madrid":[
"Diğer"
],
"Barselona":[
 "University of Barcelona",
"Polytechnic University of Catalonia",
"Universitat Oberta de Catalunya",
"Escuela de Administracion de Empresas Barcelona"
"Diğer"
],
"Sheffield":[
  "University of Sheffield",
"Sheffield Hallam University",
"The Sheffield College",
"Diğer"
],
"Oxford":[
"Oxford",
"Diğer"
],
"Nottingham":[
  "University of Nottingham",
"Nottingham Trent Unversity" ,
"Nottingham College",
"Diğer"
],
"Manchester":[
  "University of Manchester",
"Salford University",
"Manchester Metropolitan University",
"RNCM",
"Diğer"

],
"Londra":[
  "University College London",
"London School of Economics",
"Imperial College London",
"University of Westminster",
"King's College London",
"University of Greenwich",
"Imperial College London",
"Queen Mary University of London",
"SOAS University of London",
"Diğer"
],
"Kent":[
"Diğer"
],
"Durham":[
  "Durham University"
  "Diğer"

],
"Coventry":[
  "Coventry University",
"University of Warwick",
"Diğer"

],
"Birmingham":[
 "University Of Birmingham",
"Birmingham City University",
"University College Birmingham",
"Newman University",
"Aston University",
"Diğer"
],
"Bath": [
 " Bath Spa University",
"University of Bath",
"Bath College",
"Diğer"

],
"Twente":[
 " University of Twente",
"Hogeschool Saxion",
"Diğer"

],
"Tilburg":[
  "Tilburg University",
"Fontys Hogeschool Tilburg",
"Fontys School of Arts",
"Avans Hogeschool",
"Diğer"
],
"Rotterdam":[
  "Erasmus University Rotterdam",
"Rotterdam University of Applied Sciences (Hogeschool Rotterdam)",
"Islamic University of Rotterdam",
"Codarts University of Arts",
"Willem de Konig Academy",
"Diğer"

],
"Maastrich":[
  "Maastricht University",
"UCM (University College Maastricht)",
"Hotel Management School",
"ZUYD Hogeschool",
"Diğer"

],
"Leiden":[
 " Leiden University",
"Hogeschool Leiden",
"Diğer"

],
"Eindhoven":[
  "Eindhoven University of Technology",
"Fontys Eindhoven",
"Design Academy Eindhoven",
"Diğer"

],
"Delft":[
  "TU Delft",
"Inholland University of Applied Sciences",
"The Hague University of Applied Sciences",
"Diğer"

],
"Amsterdam":[
  "University of Amsterdam",
"Vrije Universiteit",
"Amsterdam University College",
"Hogeschool van Amsterdam",
"Diğer"

],
"Touluse":[
 "Université Toulouse I Capitole",
"Université Toulouse II Jean Jaurès",
"Université Toulouse III Paul Sabatier",
"Institut national des sciences appliquées de Toulouse",
"Science Po Toulouse",
"ENAC - Ecole Nationale de l'Aviation Civile",
"Institut Supérieur de l'Aaéronautique et de l'Espace",
"Ecole Nationale Vétérinaire de Toulouse",
"École nationale supérieure d'électrotechnique, d'électronique, d'informatique, d'hydraulique et des télécommunications",
"toulouse école nationale supérieure des ingénieurs en arts chimiques et technologiques",
"ICT - Institut Catholique de Toulouse ",
"Toulouse Business School",
"Diğer"

],
"Strasbourg":[
  "Université de Strasbourg ( UNISTRA )",
"Science Po Strasbourg ",
"Insa",
"Diğer"

],
"Paris":[
"Université Panthéon-Sorbonne - Paris 1",
"Université Panthéon-Assas - Paris 2",
"Université Sorbonne Nouvelle- Paris 3",
"Université de Paris",
"Parsons Paris",
"Université paris 8",
"Université paris dauphine",
"EDHEC",
"Institut Catholique de Paris",
"ISC Paris",
"Paris school of Business",
"Beaux-Arts de Paris",
"Université paris Nanterre",
"Université de Cergy-Pontoise",
"Université Paris-Est Créteil Val de Marne",
"Université paris Sud",
"Université de Versailles Saint-Quentin-en-Yvelines",
"Université Gustave Eiffel",
"Université d’Evry-Val-d’Essonne",
"Université Sorbonne Paris Nord",
"American University of Paris",
"New york University (nyu) Paris",
"science po",
"ESMOD",
"le Cordon Bleu",
"Sorbonne Université",
"Diğer"
],
"Los Angeles":[
"Diğer"
],
"Rhode Islands":[
"Diğer"
],
"Montpeiller":[
"Université de Montpellier",
"Université Paul Valéry",
"École Nationale Supérieure d'Architecture de Montpellier (ENSAM)",
"Diğer"
],
"Lyon":[
  "Université Lumiere Lyon 2",
"Université Jean Moulin Lyon 3",
"Institut National des Sciences Appliquées de Lyon",
"EMLYON Business School",
"Université Catholique de Lyon", 
"École normale supérieure de Lyon",
"Catholic School of Engineering",
"Institute for Agriculture and Food Industry, Rhone-Alpes",
"Textile and Chemical Institute of Lyon",
"Diğer"

],
"Lille":[
"Université Catholique de Lille",
"Université de Lille",
"SKEMA Business School", 
"Conservatoire National des Arts & Métiers (CNAM)",
"Ecole Centrale de Lille (Centrale Lille) - ex IDN",
"Ecole Nationale Supérieure de Chimie de Lille (Chimie Lille)",
"Ecole Nationale Supérieure des Arts et Industries Textiles (ENSAIT)",
"Ecole polytechnique universitaire de Lille (Polytech'Lille) - ex EUDIL, IAAL et IESP",
"Hautes Etudes d'Ingénieurs (HEI)",
"Institut Catholique d'Arts et Métiers (ICAM)",
"Institut Supérieur d'Agriculture (ISA)",
"Institut Supérieur d'Electronique du Numérique (ISEN)",
"Institut Supérieur de Technologie du Nord (ISTN)",
"Ecole de Hautes Etudes Commerciales du Nord (EDHEC)",
"Ecole Supérieure de Journalisme de Lille (ESJ)",
"Institut d'Administration des Entreprises de Lille (IAE Lille)",
"Institut d'Etudes Politiques de Lille (Sciences-Po Lille)",
"Institut d'Expertise Comptable de Lille (IEC)",
"Institut Supérieur Européen de Gestion de Lille (ISEG Lille)",
"Institut Universitaire de Formation des Maîtres (IUFM)",
"Institut d'Economie Scientifique et de Gestion (IESEG)",
"European School of Political and Social Sciences (ESPOL)",
"Diğer"
],
"Bordeaux":[
"Diğer"
],
"Washington":[
"Georgetown University",
"George Washington University",
"American University",
"George Mason University",
"Johns Hopkins University",
"Peabody Institute",
"Loyola University",
"Stevenson University",
"Towson University",
"Diğer"
],
"New York":[
"New York University",
"Columbia University",
"The New School",
"Pratt Institute",
"Pace University",
"Fordham University",
"Diğer"
],
"Chicago":[
"The University of Chicago",
"Northwestern University",
"Illinois Institute of Technology",
"Loyola University Chicago",
"University of Illinois at Urbana-Champaign",
"Diğer"
],
"Boston":[
"Northeastern University",
"Tufts University",
"Harvard University",
"Boston University",
"Brandeis University",
"Massachusetts Institute of Technology",
"Babson College",
"University of Massachusetts Boston",
"Benjamin Franklin Institute of Technology",
"Bay State College",
"Bentley University",
"Berklee College of Music",
"Boston Architectural College",
"Boston Baptist College",
"Boston College",
"Boston Graduate School of Psychoanalysis",
"Bunker Hill Community College",
"Cambridge College",
"Curry College",
"Eastern Nazarene College",
"Emerson College",
"Emmanuel College",
"Fisher College",
"Hebrew College",
"Hult International Business School",
"Labouré College",
"Lasell College",
"Lesley University",
"Longy School of Music of Bard College",
"Massachusetts College of Art and Design",
"Massachusetts College of Pharmacy and Health Sciences",
"William James College",
"MGH Institute of Health Professions",
"Quincy College",
"Simmons University",
"Suffolk University",
"Urban College of Boston",
"Wentworth Institute of Technology",
"Roxbury Community College",
"Diğer"
],
"Münih":[
"Technische Universität München",
"Ludwig-Maximilians-Universität",
"Hochschule für angewandte Wissenschaften München",
"Hochschule für Musik und Theater München",
"Diğer"

],
"Würzburg":[
"Diğer"
],
"Schweinfurt":[
"Diğer"
],
"Bremen":[
"Diğer"
],
"Nürnberg":[
"Diğer"
],
"Karlsruhe":[
"Duale Hochschule Baden-Württemberg Karlsruhe",
"EC Europa Campus",
"FernUniversität in Hagen - Regionalzentrum Karlsruhe",
"GoVersity - Studienzentrum Karlsruhe",
"Hochschule für Musik Karlsruhe",
"Hochschule Karlsruhe – Technik und Wirtschaft",
"International Management College",
"Karlshochschule International University",
"Karlsruher Institut für Technologie (KIT)",
"Pädagogische Hochschule Karlsruhe",
"Staatliche Akademie der Bildenden Künste Karlsruhe",
"Staatliche Hochschule für Gestaltung Karlsruhe",
"Diğer"
],
"Heidelberg":[
"Ruprecht-Karls-Universität, Heidelberg",
"Pädagogische Hochschule Heidelberg (Eğitim Fakültesi)",
"Diğer"

],
"Hamburg":[
"TU Hamburg",
"Universität Hamburg",
"Bucerius Law School",
"Hamburg Angewandte Wissenschaften (HAW)",
"Diğer"

],
"Erlangen":[
"Diğer"
],
"Berlin":[
"TU Hamburg",
"Universität Hamburg",
"Bucerius Law School",
"Hamburg Angewandte Wissenschaften (HAW)",
"Diğer"

],
"Aachen":[
"RWTH Aachen",
"FH Aachen",
"Diğer"
]
};
