import 'dart:math';

class AppValues {
  static String ghrIncogWebUrl = 'https://ghr-incog.vercel.app/';

  static int maxRating = 5;
  static var progresBarWidth = 4.0;
  static int closeDelay = 400;
  static String collegeName = 'G. H. Raisoni College of Engineering and Management, Pune';
  static String collegeNameCode = 'GHRCEM';
  static String defaultEmailFormat = '@ghrcem.raisoni.net';
  static int maxCharactersPost = 1000;
  static List<String> randomUsername = [
    'angel', 'bubbles', 'shimmer', 'angelic', 'bubbly', 'glimmer', 'baby',
    'pink', 'little', 'butterfly', 'sparkly', 'doll', 'sweet', 'sparkles',
    'dolly', 'sweetie', 'sprinkles', 'lolly', 'princess', 'fairy', 'honey',
    'snowflake', 'pretty', 'sugar', 'cherub', 'lovely', 'blossom',
    'meddlesomehummus', 'raspberrybattenburg', 'pajamastaunt', 'wetdefensive',
    'tweetpolicy', 'deadpanthrough', 'rowernuclear', 'artichokeaddress',
    'jumbleddiving', 'fastagile', 'hourarticulate', 'ridinggloves', 'etchstrategy',
    'saxendcity', 'numberlessconverting', 'taperpsycho', 'fesnyingstatistics',
    'nonceconceited', 'snoozebutthead', 'octopuscake', 'prosecutorwhirl',
    'motionobnoxious', 'languidpurser', 'throatstop', 'swindleropossum',
    'amuckhog', 'troutchick', 'bartheorize', 'brashlastage', 'waverknew',
    'horrifiedskateboard', 'jackstayjoin', 'muppetpotential', 'attractsoothe',
    'brotherlapwing', 'vipergolfing', 'volestockings', 'geekdepict', 'policesoul',
    'scootergrouse', 'giganticpentathlon', 'lettucebell', 'corianderprayer',
    'hoodlumhelicopter', 'chambermonitor', 'regimeascension', 'sussexgunpowder',
    'noticeattract', 'teefamiliar', 'shadegerman', 'stockfantastic',
    'chamoismarketing', 'annoyedsake', 'humorouscane', 'experimentcave',
    'peachchristmastide', 'readingbong', 'cynicalwellingtons', 'balancedperceive',
    'waggishlimes', 'educatedbetween', 'fascinatedfireplace', 'cleartangerine',
    'gatedwell', 'husbandpumpkin', 'pityinginform', 'evergreenled',
    'resolutedock', 'equablegibbon', 'laphum', 'farcell', 'tactlessuptight',
    'frostefficient', 'purrtapir', 'infantilegrass', 'vultureextralarge',
    'puddlingdiscipline', 'chimpanzeeassorted', 'antshoulders', 'staysailsocket',
    'massagealmonds', 'overhold', 'mineshaftteaching', 'meerkatjurymast',
    'airlinesunrise', 'skatingpituitary', 'cryodd', 'lymphtime', 'incidentmarrow',
    'oddschilis', 'excitableroomy', 'chordambitious', 'followhalf', 'relievedorder',
    'yieldinggun', 'abortivestadium', 'collarbonesuccinct', 'barrenswool', 'vomerberk',
    'hopperharpist', 'boorishoutcome', 'governmentgunnage', 'colonialspecies',
    'intendcheck', 'cottonsent', 'sordparagraph', 'strategicsauce', 'gristextra',
    'bagelstalk', 'adoringsmiley', 'ledcrack', 'grubbytattered', 'digitaltrunnel',
    'lonelysimply', 'formulaveins', 'unthinkingallow', 'fadedproduct', 'birchwoodjoke',
    'lopsidedclam', 'perfumedbreed', 'onlookerstork', 'playoffscricket', 'fistcourse',
    'tadaunnatural', 'whimsicalquiet', 'increasedteen', 'unlockthan', 'repulsivenye',
    'understoodhardly', 'bedstrawblouse', 'stainavow', 'obviousprimarily',
    'constructpreference', 'investmentstroke', 'infusestep', 'navelruddy',
    'handmadeidle', 'troubleterrorism', 'islandsaxophone', 'gesturerebel',
    'pilcharddeposit', 'wheneverkedge', 'poinsettiaelfin', 'usuallygrove',
    'corpstrend', 'squawkaccident', 'agotaxidriver', 'worncurling', 'clifdensignpost',
    'desirehistorical', 'winterbag', 'unbiasedpolitical', 'sampleindex', 'includingwhen',
    'deficientrespectful', 'accuselethal', 'epidermiseverywhere', 'dairymillion',
    'anvilrosary', 'spiderdreary', 'scandalousanimated', 'downrightnap', 'resolvedfitzroy',
    'gorgeousburnished', 'openingitem', 'cootdecember', 'housingminidisc', 'stalkzoglin',
    'verbhyundai', 'beatdickhead', 'hypnoticrelatively', 'anyfrontal', 'carefreebison',
    'loganberrieshosiery', 'cheesesteakdistance', 'reactmediocre', 'fightbeehives',
    'postulatecommand', 'forwardbottle', 'dollselated', 'specialcompass', 'golferadapt',
    'teammateminor', 'havetested', 'tunateeming', 'dwellresearch', 'unawarehover',
    'infectionhidden', 'scanclient', 'pastoralpoloshirt', 'toyotadistraught',
    'sacgreetings', 'skieremployer', 'fatguideline', 'earringsclementine',
    'wrestleshrug', 'blotchedcartwheel', 'reasonableboa', 'musicalunfolded',
    'cute.as.ducks', 'casanova', 'real_name_hidden', 'HairyPoppins', 'fedora_the_explorer',
    'OP_rah', 'YellowSnowman', 'JoeNotExotic'
  ];

  static List<String> generateUniqueUsernames(List<String> baseUsernames, int count) {
    Set<String> uniqueUsernames = {};
    List<String> result = [];

    while (uniqueUsernames.length < count) {
      String randomBase = baseUsernames[Random().nextInt(baseUsernames.length)];
      int randomNumber = Random().nextInt(100); // Adjust the range as needed
      String username = '$randomBase$randomNumber';

      if (!uniqueUsernames.contains(username)) {
        uniqueUsernames.add(username);
        result.add(username);
      }
    }

    return result;
  }

}