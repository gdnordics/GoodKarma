import 'package:good_karma_app/models/event_locations.dart';

var city_locations = {
"aarhus":"Aarhus",
"abu_dhabi":"Abu Dhabi",
"abuja":"Abuja",
"accra":"Accra",
"adamstown":"Adamstown",
"addis_ababa":"Addis Ababa",
"algiers":"Algiers",
"alofi":"Alofi",
"amman":"Amman",
"amsterdam":"Amsterdam",
"andorra_la_vella":"Andorra La Vella",
"ankara":"Ankara",
"antananarivo":"Antananarivo",
"apia":"Apia",
"ashgabat":"Ashgabat",
"asmara":"Asmara",
"astana":"Astana",
"asuncion":"Asunción",
"athens":"Athens",
"avarua":"Avarua",
"baghdad":"Baghdad",
"baku":"Baku",
"bamako":"Bamako",
"bandar_seri_begawan":"Bandar Seri Begawan",
"bangkok":"Bangkok",
"bangui":"Bangui",
"banjul":"Banjul",
"basseterre":"Basseterre",
"beijing":"Beijing",
"beirut":"Beirut",
"belgrade":"Belgrade",
"belmopan":"Belmopan",
"berlin":"Berlin",
"bern":"Bern",
"bishkek":"Bishkek",
"bissau":"Bissau",
"bogota":"Bogotá",
"brades_plymouth":"Brades, Plymouth",
"brasilia":"Brasília",
"bratislava":"Bratislava",
"brazzaville":"Brazzaville",
"bridgetown":"Bridgetown",
"brussels":"Brussels",
"bucharest":"Bucharest",
"budapest":"Budapest",
"buenos_aires":"Buenos Aires",
"bujumbura":"Bujumbura",
"cairo":"Cairo",
"canberra":"Canberra",
"cape_town":"Cape Town",
"caracas":"Caracas",
"castries":"Castries",
"cayenne":"Cayenne",
"charlotte_amalie":"Charlotte Amalie",
"chisinau":"Chisinau",
"cockburn_town":"Cockburn Town",
"conakry":"Conakry",
"copenhagen":"Copenhagen",
"dakar":"Dakar",
"damascus":"Damascus",
"dhaka":"Dhaka",
"dili":"Dili",
"djibouti_city":"Djibouti-city",
"dodoma":"Dodoma",
"doha":"Doha",
"douglas":"Douglas",
"dublin":"Dublin",
"dushanbe":"Dushanbe",
"el_aaiun":"El Aaiun",
"flying_fish_cove":"Flying Fish Cove",
"freetown":"Freetown",
"funafuti":"Funafuti",
"gaborone":"Gaborone",
"george_town":"George Town",
"georgetown":"Georgetown",
"gibraltar":"Gibraltar",
"gothenburg":"Gothenburg",
"guatemala_city":"Guatemala City",
"gustavia_saint_barthelemy":"Gustavia, Saint Barthélemy",
"hagatna":"Hagatna",
"hamilton":"Hamilton",
"hanoi":"Hanoi",
"harare":"Harare",
"havana":"Havana",
"helsinki":"Helsinki",
"hong_kong_city":"Hong Kong City",
"honiara":"Honiara",
"islamabad":"Islamabad",
"jakarta":"Jakarta",
"jamestown":"Jamestown",
"jerusalem":"Jerusalem",
"juba":"Juba",
"kabul":"Kabul",
"kampala":"Kampala",
"kathmandu":"Kathmandu",
"khartoum":"Khartoum",
"kiev":"Kiev",
"kigali":"Kigali",
"kingston":"Kingston",
"kingstown":"Kingstown",
"kinshasa":"Kinshasa",
"kuala_lumpur":"Kuala Lumpur",
"kuwait_city":"Kuwait City",
"libreville":"Libreville",
"lilongwe":"Lilongwe",
"lima":"Lima",
"lisbon":"Lisbon",
"ljubljana":"Ljubljana",
"lome":"Lomé",
"london":"London",
"luanda":"Luanda",
"lusaka":"Lusaka",
"luxembourg":"Luxembourg",
"madrid":"Madrid",
"majuro":"Majuro",
"malabo":"Malabo",
"male":"Malé",
"managua":"Managua",
"manama":"Manama",
"manila":"Manila",
"maputo":"Maputo",
"marigot":"Marigot",
"maseru":"Maseru",
"mata_utu":"Mata-Utu",
"mbabane":"Mbabane",
"mexico_city":"Mexico City",
"minsk":"Minsk",
"mogadishu":"Mogadishu",
"monaco":"Monaco",
"monrovia":"Monrovia",
"montevideo":"Montevideo",
"moroni":"Moroni",
"moscow":"Moscow",
"muscat":"Muscat",
"n_djamena":"N’Djamena",
"nairobi":"Nairobi",
"nassau":"Nassau",
"naypyidaw":"Naypyidaw",
"new_delhi":"New Delhi",
"new_york":"New York",
"ngerulmud":"Ngerulmud",
"niamey":"Niamey",
"nicosia":"Nicosia",
"nouakchott":"Nouakchott",
"noumea":"Nouméa",
"nuku_alofa":"Nuku’alofa",
"nukunonu_atafutokelau":"Nukunonu, Atafu,Tokelau",
"nuuk":"Nuuk",
"oranjestad":"Oranjestad",
"oslo":"Oslo",
"ottawa":"Ottawa",
"ouagadougou":"Ouagadougou",
"pago_pago":"Pago Pago",
"palikir":"Palikir",
"panama_city":"Panama City",
"papeete":"Papeete",
"paramaribo":"Paramaribo",
"paris":"Paris",
"philipsburg":"Philipsburg",
"phnom_penh":"Phnom Penh",
"podgorica":"Podgorica",
"port_louis":"Port Louis",
"port_moresby":"Port Moresby",
"port_of_spain":"Port of Spain",
"port_vila":"Port Vila",
"port_au_prince":"Port-au-prince",
"porto_novo":"Porto-Novo",
"prague":"Prague",
"praia":"Praia",
"pristina":"Pristina",
"pyongyang":"Pyongyang",
"quito":"Quito",
"rabat":"Rabat",
"ramallah_and_gaza":"Ramallah and Gaza",
"reykjavik":"Reykjavík",
"riga":"Riga",
"riyadh":"Riyadh",
"road_town":"Road Town",
"rome":"Rome",
"roseau":"Roseau",
"saint_helier":"Saint Helier",
"saint_johns":"Saint Johns",
"saint_peter_port":"Saint Peter Port",
"saint_pierre":"Saint-Pierre",
"saipan":"Saipan",
"san_francisco":"San Francisco",
"san_jose":"San José",
"san_juan":"San Juan",
"san_marino":"San Marino",
"san_salvador":"San Salvador",
"sana_a":"Sana’a",
"santiago":"Santiago",
"santo_domingo":"Santo Domingo",
"sao_tome":"Sao Tome",
"sarajevo":"Sarajevo",
"seoul":"Seoul",
"singapore":"Singapore",
"skopje":"Skopje",
"sofia":"Sofia",
"sri_jayawardenapura_kotte":"Sri Jayawardenapura-kotte",
"st_georges":"St. George’s",
"stanley":"Stanley",
"stockholm":"Stockholm",
"sucre":"Sucre",
"suva":"Suva",
"taipei":"Taipei",
"tallinn":"Tallinn",
"tarawa":"Tarawa",
"tashkent":"Tashkent",
"tbilisi":"Tbilisi",
"tegucigalpa":"Tegucigalpa",
"tehran":"Tehran",
"the_valley":"The Valley",
"thimphu":"Thimphu",
"tirana":"Tirana",
"tiraspol":"Tiraspol",
"tokyo":"Tokyo",
"torshavn":"Tórshavn",
"tripoli":"Tripoli",
"tunis":"Tunis",
"ulan_bator":"Ulan Bator",
"vaduz":"Vaduz",
"valletta":"Valletta",
"vatican_city":"Vatican City",
"victoria":"Victoria",
"vienna":"Vienna",
"vientiane":"Vientiane",
"vilnius":"Vilnius",
"warsaw":"Warsaw",
"washington_dc":"Washington D.C.",
"wellington":"Wellington",
"west_island_cocos_islands":"West Island, Cocos Islands",
"willemstad":"Willemstad",
"windhoek":"Windhoek",
"yamoussoukro":"Yamoussoukro",
"yaounde":"Yaoundé",
"yaren":"Yaren",
"yerevan":"Yerevan",
"zagreb":"Zagreb"
};

List<Location> locationsList = city_locations.entries.map((e)=> Location(e.key, e.value)).toList();