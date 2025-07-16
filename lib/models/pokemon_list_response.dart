class PokemonListResponse {
  List<Data>? data;
  dynamic page;
  dynamic pageSize;
  dynamic count;
  dynamic totalCount;

  PokemonListResponse({
    this.data,
    this.page,
    this.pageSize,
    this.count,
    this.totalCount,
  });

  PokemonListResponse.fromJson(Map<String, dynamic> json) {
    data =
        json["data"] == null
            ? null
            : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    page = json["page"];
    pageSize = json["pageSize"];
    count = json["count"];
    totalCount = json["totalCount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data["data"] = this.data!.map((e) => e.toJson()).toList();
    }
    data["page"] = page;
    data["pageSize"] = pageSize;
    data["count"] = count;
    data["totalCount"] = totalCount;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? supertype;
  List<String>? subtypes;
  String? hp;
  List<String>? types;
  String? evolvesFrom;
  List<Attacks>? attacks;
  List<Weaknesses>? weaknesses;
  List<Resistances>? resistances;
  List<String>? retreatCost;
  dynamic convertedRetreatCost;
  Set? set;
  String? number;
  String? artist;
  String? rarity;
  String? flavorText;
  List<dynamic>? nationalPokedexNumbers;
  Legalities1? legalities;
  Images1? images;
  Tcgplayer? tcgplayer;
  Cardmarket? cardmarket;

  Data({
    this.id,
    this.name,
    this.supertype,
    this.subtypes,
    this.hp,
    this.types,
    this.evolvesFrom,
    this.attacks,
    this.weaknesses,
    this.resistances,
    this.retreatCost,
    this.convertedRetreatCost,
    this.set,
    this.number,
    this.artist,
    this.rarity,
    this.flavorText,
    this.nationalPokedexNumbers,
    this.legalities,
    this.images,
    this.tcgplayer,
    this.cardmarket,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    supertype = json["supertype"];
    subtypes =
        json["subtypes"] == null ? null : List<String>.from(json["subtypes"]);
    hp = json["hp"];
    types = json["types"] == null ? null : List<String>.from(json["types"]);
    evolvesFrom = json["evolvesFrom"];
    attacks =
        json["attacks"] == null
            ? null
            : (json["attacks"] as List)
                .map((e) => Attacks.fromJson(e))
                .toList();
    weaknesses =
        json["weaknesses"] == null
            ? null
            : (json["weaknesses"] as List)
                .map((e) => Weaknesses.fromJson(e))
                .toList();
    resistances =
        json["resistances"] == null
            ? null
            : (json["resistances"] as List)
                .map((e) => Resistances.fromJson(e))
                .toList();
    retreatCost =
        json["retreatCost"] == null
            ? null
            : List<String>.from(json["retreatCost"]);
    convertedRetreatCost = json["convertedRetreatCost"];
    set = json["set"] == null ? null : Set.fromJson(json["set"]);
    number = json["number"];
    artist = json["artist"];
    rarity = json["rarity"];
    flavorText = json["flavorText"];
    nationalPokedexNumbers =
        json["nationalPokedexNumbers"] == null
            ? null
            : List<dynamic>.from(json["nationalPokedexNumbers"]);
    legalities =
        json["legalities"] == null
            ? null
            : Legalities1.fromJson(json["legalities"]);
    images = json["images"] == null ? null : Images1.fromJson(json["images"]);
    tcgplayer =
        json["tcgplayer"] == null
            ? null
            : Tcgplayer.fromJson(json["tcgplayer"]);
    cardmarket =
        json["cardmarket"] == null
            ? null
            : Cardmarket.fromJson(json["cardmarket"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["supertype"] = supertype;
    if (subtypes != null) {
      data["subtypes"] = subtypes;
    }
    data["hp"] = hp;
    if (types != null) {
      data["types"] = types;
    }
    data["evolvesFrom"] = evolvesFrom;
    if (attacks != null) {
      data["attacks"] = attacks?.map((e) => e.toJson()).toList();
    }
    if (weaknesses != null) {
      data["weaknesses"] = weaknesses?.map((e) => e.toJson()).toList();
    }
    if (resistances != null) {
      data["resistances"] = resistances?.map((e) => e.toJson()).toList();
    }
    if (retreatCost != null) {
      data["retreatCost"] = retreatCost;
    }
    data["convertedRetreatCost"] = convertedRetreatCost;
    if (set != null) {
      data["set"] = set?.toJson();
    }
    data["number"] = number;
    data["artist"] = artist;
    data["rarity"] = rarity;
    data["flavorText"] = flavorText;
    if (nationalPokedexNumbers != null) {
      data["nationalPokedexNumbers"] = nationalPokedexNumbers;
    }
    if (legalities != null) {
      data["legalities"] = legalities?.toJson();
    }
    if (images != null) {
      data["images"] = images?.toJson();
    }
    if (tcgplayer != null) {
      data["tcgplayer"] = tcgplayer?.toJson();
    }
    if (cardmarket != null) {
      data["cardmarket"] = cardmarket?.toJson();
    }
    return data;
  }
}

class Cardmarket {
  String? url;
  String? updatedAt;
  Prices1? prices;

  Cardmarket({this.url, this.updatedAt, this.prices});

  Cardmarket.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    updatedAt = json["updatedAt"];
    prices = json["prices"] == null ? null : Prices1.fromJson(json["prices"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["url"] = url;
    data["updatedAt"] = updatedAt;
    if (prices != null) {
      data["prices"] = prices?.toJson();
    }
    return data;
  }
}

class Prices1 {
  dynamic averageSellPrice;
  dynamic lowPrice;
  dynamic trendPrice;
  dynamic germanProLow;
  dynamic suggestedPrice;
  dynamic reverseHoloSell;
  dynamic reverseHoloLow;
  dynamic reverseHoloTrend;
  dynamic lowPriceExPlus;
  dynamic avg1;
  dynamic avg7;
  dynamic avg30;
  dynamic reverseHoloAvg1;
  dynamic reverseHoloAvg7;
  dynamic reverseHoloAvg30;

  Prices1({
    this.averageSellPrice,
    this.lowPrice,
    this.trendPrice,
    this.germanProLow,
    this.suggestedPrice,
    this.reverseHoloSell,
    this.reverseHoloLow,
    this.reverseHoloTrend,
    this.lowPriceExPlus,
    this.avg1,
    this.avg7,
    this.avg30,
    this.reverseHoloAvg1,
    this.reverseHoloAvg7,
    this.reverseHoloAvg30,
  });

  Prices1.fromJson(Map<String, dynamic> json) {
    averageSellPrice = json["averageSellPrice"];
    lowPrice = json["lowPrice"];
    trendPrice = json["trendPrice"];
    germanProLow = json["germanProLow"];
    suggestedPrice = json["suggestedPrice"];
    reverseHoloSell = json["reverseHoloSell"];
    reverseHoloLow = json["reverseHoloLow"];
    reverseHoloTrend = json["reverseHoloTrend"];
    lowPriceExPlus = json["lowPriceExPlus"];
    avg1 = json["avg1"];
    avg7 = json["avg7"];
    avg30 = json["avg30"];
    reverseHoloAvg1 = json["reverseHoloAvg1"];
    reverseHoloAvg7 = json["reverseHoloAvg7"];
    reverseHoloAvg30 = json["reverseHoloAvg30"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["averageSellPrice"] = averageSellPrice;
    data["lowPrice"] = lowPrice;
    data["trendPrice"] = trendPrice;
    data["germanProLow"] = germanProLow;
    data["suggestedPrice"] = suggestedPrice;
    data["reverseHoloSell"] = reverseHoloSell;
    data["reverseHoloLow"] = reverseHoloLow;
    data["reverseHoloTrend"] = reverseHoloTrend;
    data["lowPriceExPlus"] = lowPriceExPlus;
    data["avg1"] = avg1;
    data["avg7"] = avg7;
    data["avg30"] = avg30;
    data["reverseHoloAvg1"] = reverseHoloAvg1;
    data["reverseHoloAvg7"] = reverseHoloAvg7;
    data["reverseHoloAvg30"] = reverseHoloAvg30;
    return data;
  }
}

class Tcgplayer {
  String? url;
  String? updatedAt;
  Prices? prices;

  Tcgplayer({this.url, this.updatedAt, this.prices});

  Tcgplayer.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    updatedAt = json["updatedAt"];
    prices = json["prices"] == null ? null : Prices.fromJson(json["prices"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["url"] = url;
    data["updatedAt"] = updatedAt;
    if (prices != null) {
      data["prices"] = prices?.toJson();
    }
    return data;
  }
}

class Prices {
  Holofoil? holofoil;
  ReverseHolofoil? reverseHolofoil;

  Prices({this.holofoil, this.reverseHolofoil});

  Prices.fromJson(Map<String, dynamic> json) {
    holofoil =
        json["holofoil"] == null ? null : Holofoil.fromJson(json["holofoil"]);
    reverseHolofoil =
        json["reverseHolofoil"] == null
            ? null
            : ReverseHolofoil.fromJson(json["reverseHolofoil"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (holofoil != null) {
      data["holofoil"] = holofoil?.toJson();
    }
    if (reverseHolofoil != null) {
      data["reverseHolofoil"] = reverseHolofoil?.toJson();
    }
    return data;
  }
}

class ReverseHolofoil {
  dynamic low;
  dynamic mid;
  dynamic high;
  dynamic market;
  dynamic directLow;

  ReverseHolofoil({this.low, this.mid, this.high, this.market, this.directLow});

  ReverseHolofoil.fromJson(Map<String, dynamic> json) {
    low = json["low"];
    mid = json["mid"];
    high = json["high"];
    market = json["market"];
    directLow = json["directLow"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["low"] = low;
    data["mid"] = mid;
    data["high"] = high;
    data["market"] = market;
    data["directLow"] = directLow;
    return data;
  }
}

class Holofoil {
  dynamic low;
  dynamic mid;
  dynamic high;
  dynamic market;
  dynamic directLow;

  Holofoil({this.low, this.mid, this.high, this.market, this.directLow});

  Holofoil.fromJson(Map<String, dynamic> json) {
    low = json["low"];
    mid = json["mid"];
    high = json["high"];
    market = json["market"];
    directLow = json["directLow"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["low"] = low;
    data["mid"] = mid;
    data["high"] = high;
    data["market"] = market;
    data["directLow"] = directLow;
    return data;
  }
}

class Images1 {
  String? small;
  String? large;

  Images1({this.small, this.large});

  Images1.fromJson(Map<String, dynamic> json) {
    small = json["small"];
    large = json["large"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["small"] = small;
    data["large"] = large;
    return data;
  }
}

class Legalities1 {
  String? unlimited;

  Legalities1({this.unlimited});

  Legalities1.fromJson(Map<String, dynamic> json) {
    unlimited = json["unlimited"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["unlimited"] = unlimited;
    return data;
  }
}

class Set {
  String? id;
  String? name;
  String? series;
  dynamic prdynamicedTotal;
  dynamic total;
  Legalities? legalities;
  String? ptcgoCode;
  String? releaseDate;
  String? updatedAt;
  Images? images;

  Set({
    this.id,
    this.name,
    this.series,
    this.prdynamicedTotal,
    this.total,
    this.legalities,
    this.ptcgoCode,
    this.releaseDate,
    this.updatedAt,
    this.images,
  });

  Set.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    series = json["series"];
    prdynamicedTotal = json["prdynamicedTotal"];
    total = json["total"];
    legalities =
        json["legalities"] == null
            ? null
            : Legalities.fromJson(json["legalities"]);
    ptcgoCode = json["ptcgoCode"];
    releaseDate = json["releaseDate"];
    updatedAt = json["updatedAt"];
    images = json["images"] == null ? null : Images.fromJson(json["images"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["series"] = series;
    data["prdynamicedTotal"] = prdynamicedTotal;
    data["total"] = total;
    if (legalities != null) {
      data["legalities"] = legalities?.toJson();
    }
    data["ptcgoCode"] = ptcgoCode;
    data["releaseDate"] = releaseDate;
    data["updatedAt"] = updatedAt;
    if (images != null) {
      data["images"] = images?.toJson();
    }
    return data;
  }
}

class Images {
  String? symbol;
  String? logo;

  Images({this.symbol, this.logo});

  Images.fromJson(Map<String, dynamic> json) {
    symbol = json["symbol"];
    logo = json["logo"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["symbol"] = symbol;
    data["logo"] = logo;
    return data;
  }
}

class Legalities {
  String? unlimited;

  Legalities({this.unlimited});

  Legalities.fromJson(Map<String, dynamic> json) {
    unlimited = json["unlimited"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["unlimited"] = unlimited;
    return data;
  }
}

class Resistances {
  String? type;
  String? value;

  Resistances({this.type, this.value});

  Resistances.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["value"] = value;
    return data;
  }
}

class Weaknesses {
  String? type;
  String? value;

  Weaknesses({this.type, this.value});

  Weaknesses.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["value"] = value;
    return data;
  }
}

class Attacks {
  String? name;
  List<String>? cost;
  dynamic convertedEnergyCost;
  String? damage;
  String? text;

  Attacks({
    this.name,
    this.cost,
    this.convertedEnergyCost,
    this.damage,
    this.text,
  });

  Attacks.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    cost = json["cost"] == null ? null : List<String>.from(json["cost"]);
    convertedEnergyCost = json["convertedEnergyCost"];
    damage = json["damage"];
    text = json["text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    if (cost != null) {
      data["cost"] = cost;
    }
    data["convertedEnergyCost"] = convertedEnergyCost;
    data["damage"] = damage;
    data["text"] = text;
    return data;
  }
}
