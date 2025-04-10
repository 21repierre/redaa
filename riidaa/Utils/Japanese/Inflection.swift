//
//  Inflection.swift
//  riidaa
//
//  Created by Pierre on 2025/03/27.
//

public enum WordType: String, Sendable, CaseIterable {
    case v
    case v1
    case v1d
    case v1p
    
    case v5
    case v5d
    case v5s
    case v5ss
    case v5sp
    
    case vs
    case vk
    case vz
    case te_form
    case masu_form
    case adj_i = "adj-i"
    case ba_form
    case ya_form
    case nasai_form
    case ta_form
    case masen_form
    case ku_form
    
    static let childrenMap: [WordType: [WordType]] = [
        .v: [.v1, .v5, .vs, .vk, .vz],
        .v1: [.v1d, .v1p],
        .v5: [.v5d, .v5s],
        .v5s: [.v5ss, .v5sp],
    ]
    
    public var children: [WordType] {
        return (WordType.childrenMap[self] ?? []).flatMap { $0.children }
    }
    
    public static func fromString(s: String) -> WordType? {
        return self.allCases.first{ $0.rawValue == s }
    }
}

public enum InflectionRule: String, Sendable, Identifiable {
    public var id: Self { self }
    
    case masu = "ーます"
    case te = "ーて"
    case iru = "ーいる"
    case ba = "ーば"
    case ya = "ーゃ"
    case cha = "ーちゃ"
    case chau = "ーちゃう"
    case shimau = "ーしまう"
    case chimau = "ーちまう"
    case nasai = "ーなさい"
    case sou = "ーそう"
    case sugiru = "ーすぎる"
    case ta = "ーた"
    case negative = "negative"
    case causative = "causative"
    case short_causative = "short causative"
    case tai = "ーたい"
    case tara = "ーたら"
    case tari = "ーたり"
    case zu = "ーず" //
    case nu = "ーぬ" //
    case n = "ーん" //
    case nbakari = "ーんばかり" //
    case ntosuru = "ーんとする" //
    case mu = "ーむ" //
    case zaru = "ーざる" //
    case neba = "ーねば" //
    case ku = "ーく"
    case imperative = "imperative" //
    case continuative = "continuative" //
    case sa = "ーさ" //
    case passive = "passive" //
    case potential = "potential" //
    case potential_passive = "potential or passive" //
    case volitional = "volitional" //
    case volitional_slang = "volitional slang" //
    case mai = "ーまい" //
    case oku = "ーおく" //
    case ki = "ーき" //
    case ge = "ーげ" //
    case garu = "ーがる" //
    case e = "ーえ" //
    case n_slang = "ーんな" //
    case imperative_negative_slang = "imperative negative slang" //
    case kansai_negative = "関西弁 negative" //
    case kansai_te = "関西弁　ーて" //
    case kansai_ta = "関西弁　ーた" //
    case kansai_tara = "関西弁　ーたら" //
    case kansai_tari = "関西弁　ーたり" //
    case kansai_adj_te = "関西弁 adjective ーて" //
    case kansai_adj_negative = "関西弁 adjective negative" //
    
}

public struct Inflection : Sendable {
    
    public let base: String
    public let inflection: String
    public let baseTypes: [WordType]
    public let inflectedTypes: [WordType]
    
    public static let inflectionRules: [InflectionRule: [Inflection]] = [
        .masu: [
            Inflection(base: "る", inflection: "ます", baseTypes: [WordType.v1d], inflectedTypes: [WordType.masu_form]),
            
            Inflection(base: "う", inflection: "います", baseTypes: [WordType.v5d], inflectedTypes: [WordType.masu_form]),
            Inflection(base: "つ", inflection: "ちます", baseTypes: [WordType.v5d], inflectedTypes: [WordType.masu_form]),
            Inflection(base: "る", inflection: "ります", baseTypes: [WordType.v5d], inflectedTypes: [WordType.masu_form]),
            Inflection(base: "ぬ", inflection: "にます", baseTypes: [WordType.v5d], inflectedTypes: [WordType.masu_form]),
            Inflection(base: "ぶ", inflection: "びます", baseTypes: [WordType.v5d], inflectedTypes: [WordType.masu_form]),
            Inflection(base: "む", inflection: "みます", baseTypes: [WordType.v5d], inflectedTypes: [WordType.masu_form]),
            Inflection(base: "く", inflection: "きます", baseTypes: [WordType.v5d], inflectedTypes: [WordType.masu_form]),
            Inflection(base: "ぐ", inflection: "ぎます", baseTypes: [WordType.v5d], inflectedTypes: [WordType.masu_form]),
            Inflection(base: "す", inflection: "します", baseTypes: [WordType.v5d], inflectedTypes: [WordType.masu_form]),
            
            Inflection(base: "する", inflection: "します", baseTypes: [WordType.vs], inflectedTypes: [WordType.masu_form]),
            Inflection(base: "為る", inflection: "為ます", baseTypes: [WordType.vs], inflectedTypes: [WordType.masu_form]),
            
            Inflection(base: "くる", inflection: "きます", baseTypes: [WordType.vk], inflectedTypes: [WordType.masu_form]),
            Inflection(base: "来る", inflection: "来ます", baseTypes: [WordType.vk], inflectedTypes: [WordType.masu_form]),
            Inflection(base: "來る", inflection: "來ます", baseTypes: [WordType.vk], inflectedTypes: [WordType.masu_form]),
        ],
        .te: [
            Inflection(base: "い", inflection: "くて", baseTypes: [WordType.adj_i], inflectedTypes: [WordType.te_form]),
            
            Inflection(base: "る", inflection: "て", baseTypes: [WordType.v1], inflectedTypes: [WordType.te_form]),
            
            Inflection(base: "う", inflection: "って", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "つ", inflection: "って", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "る", inflection: "って", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            
            Inflection(base: "ぬ", inflection: "んで", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "ぶ", inflection: "んで", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "む", inflection: "んで", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            
            Inflection(base: "く", inflection: "いて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "ぐ", inflection: "いで", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "す", inflection: "して", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            
            Inflection(base: "ずる", inflection: "じて", baseTypes: [WordType.vk], inflectedTypes: [WordType.te_form]),
            
            Inflection(base: "する", inflection: "して", baseTypes: [WordType.vs], inflectedTypes: [WordType.te_form]),
            Inflection(base: "為る", inflection: "為て", baseTypes: [WordType.vs], inflectedTypes: [WordType.te_form]),
            
            Inflection(base: "くる", inflection: "きて", baseTypes: [WordType.vk], inflectedTypes: [WordType.te_form]),
            Inflection(base: "来る", inflection: "来て", baseTypes: [WordType.vk], inflectedTypes: [WordType.te_form]),
            Inflection(base: "來る", inflection: "來て", baseTypes: [WordType.vk], inflectedTypes: [WordType.te_form]),
            
            Inflection(base: "いく", inflection: "いって", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "行く", inflection: "行って", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "逝く", inflection: "逝って", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "往く", inflection: "往って", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            
            Inflection(base: "こう", inflection: "こうて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "とう", inflection: "とうて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "請う", inflection: "請うて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "乞う", inflection: "乞うて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "恋う", inflection: "恋うて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "問う", inflection: "問うて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "訪う", inflection: "訪うて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "宣う", inflection: "宣うて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "曰う", inflection: "曰うて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "給う", inflection: "給うて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "賜う", inflection: "賜うて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "揺蕩う", inflection: "揺蕩うて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            
            Inflection(base: "のたまう", inflection: "のたもうて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "たまう", inflection: "たもうて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
            Inflection(base: "たゆたう", inflection: "たゆとうて", baseTypes: [WordType.v5], inflectedTypes: [WordType.te_form]),
        ],
        .iru: [
            Inflection(base: "て", inflection: "ている", baseTypes: [WordType.te_form], inflectedTypes: [WordType.v1d]),
            Inflection(base: "て", inflection: "てる", baseTypes: [WordType.te_form], inflectedTypes: [WordType.v1d]),
            
            Inflection(base: "で", inflection: "でいる", baseTypes: [WordType.te_form], inflectedTypes: [WordType.v1d]),
            Inflection(base: "で", inflection: "でる", baseTypes: [WordType.te_form], inflectedTypes: [WordType.v1d]),
        ],
        .ba: [
            Inflection(base: "い", inflection: "ければ", baseTypes: [WordType.adj_i], inflectedTypes: [WordType.ba_form]),
            Inflection(base: "う", inflection: "えば", baseTypes: [WordType.v5], inflectedTypes: [WordType.ba_form]),
            Inflection(base: "つ", inflection: "てば", baseTypes: [WordType.v5], inflectedTypes: [WordType.ba_form]),
            Inflection(base: "る", inflection: "れば", baseTypes: [WordType.v5, WordType.v1, WordType.vk, WordType.vs, WordType.vz], inflectedTypes: [WordType.ba_form]),
            Inflection(base: "ぬ", inflection: "ねば", baseTypes: [WordType.v5], inflectedTypes: [WordType.ba_form]),
            Inflection(base: "ぶ", inflection: "べば", baseTypes: [WordType.v5], inflectedTypes: [WordType.ba_form]),
            Inflection(base: "む", inflection: "めば", baseTypes: [WordType.v5], inflectedTypes: [WordType.ba_form]),
            Inflection(base: "く", inflection: "けば", baseTypes: [WordType.v5], inflectedTypes: [WordType.ba_form]),
            Inflection(base: "ぐ", inflection: "げば", baseTypes: [WordType.v5], inflectedTypes: [WordType.ba_form]),
            Inflection(base: "す", inflection: "せば", baseTypes: [WordType.v5], inflectedTypes: [WordType.ba_form]),
            Inflection(base: "", inflection: "れば", baseTypes: [WordType.masu_form], inflectedTypes: [WordType.ba_form]),
        ],
        .ya: [
            Inflection(base: "れば", inflection: "りゃ", baseTypes: [WordType.ba_form], inflectedTypes: [WordType.ya_form]),
            Inflection(base: "ければ", inflection: "きゃ", baseTypes: [WordType.ba_form], inflectedTypes: [WordType.ya_form]),
            Inflection(base: "えば", inflection: "や", baseTypes: [WordType.ba_form], inflectedTypes: [WordType.ya_form]),
            Inflection(base: "けば", inflection: "きゃ", baseTypes: [WordType.ba_form], inflectedTypes: [WordType.ya_form]),
            Inflection(base: "げば", inflection: "ぎゃ", baseTypes: [WordType.ba_form], inflectedTypes: [WordType.ya_form]),
            Inflection(base: "せば", inflection: "しゃ", baseTypes: [WordType.ba_form], inflectedTypes: [WordType.ya_form]),
            Inflection(base: "てば", inflection: "ちゃ", baseTypes: [WordType.ba_form], inflectedTypes: [WordType.ya_form]),
            Inflection(base: "ねば", inflection: "にゃ", baseTypes: [WordType.ba_form], inflectedTypes: [WordType.ya_form]),
            Inflection(base: "べば", inflection: "びゃ", baseTypes: [WordType.ba_form], inflectedTypes: [WordType.ya_form]),
            Inflection(base: "めば", inflection: "みゃ", baseTypes: [WordType.ba_form], inflectedTypes: [WordType.ya_form]),
        ],
        .cha: [
            Inflection(base: "る", inflection: "ちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ぐ", inflection: "いじゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "く", inflection: "いちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "す", inflection: "しちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "う", inflection: "っちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "く", inflection: "っちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "つ", inflection: "っちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "る", inflection: "っちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "ぬ", inflection: "んじゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "ぶ", inflection: "んじゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "む", inflection: "んじゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "ずる", inflection: "じちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.vz]),
            Inflection(base: "する", inflection: "しちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.vs]),
            Inflection(base: "為る", inflection: "為ちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.vs]),
            Inflection(base: "くる", inflection: "きちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.vk]),
            Inflection(base: "来る", inflection: "来ちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.vk]),
            Inflection(base: "來る", inflection: "來ちゃ", baseTypes: [WordType.v5], inflectedTypes: [WordType.vk]),
        ],
        .chau: [
            Inflection(base: "る", inflection: "ちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ぐ", inflection: "いじゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "く", inflection: "いちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "す", inflection: "しちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "う", inflection: "っちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "く", inflection: "っちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "つ", inflection: "っちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "る", inflection: "っちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "ぬ", inflection: "んじゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "ぶ", inflection: "んじゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "む", inflection: "んじゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "ずる", inflection: "じちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.vz]),
            Inflection(base: "する", inflection: "しちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.vs]),
            Inflection(base: "為る", inflection: "為ちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.vs]),
            Inflection(base: "くる", inflection: "きちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.vk]),
            Inflection(base: "来る", inflection: "来ちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.vk]),
            Inflection(base: "來る", inflection: "來ちゃう", baseTypes: [WordType.v5], inflectedTypes: [WordType.vk]),
        ],
        .chimau: [
            Inflection(base: "る", inflection: "ちまう", baseTypes: [WordType.v1], inflectedTypes: [WordType.v5]),
            Inflection(base: "ぐ", inflection: "いじまう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "く", inflection: "いちまう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "す", inflection: "しちまう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "う", inflection: "っちまう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "ぬ", inflection: "んじまう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "ぶ", inflection: "んじまう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "む", inflection: "んじまう", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5]),
            Inflection(base: "ずる", inflection: "じちまう", baseTypes: [WordType.vz], inflectedTypes: [WordType.v5]),
            Inflection(base: "する", inflection: "しちまう", baseTypes: [WordType.vs], inflectedTypes: [WordType.v5]),
            Inflection(base: "為る", inflection: "為ちまう", baseTypes: [WordType.vs], inflectedTypes: [WordType.v5]),
            Inflection(base: "くる", inflection: "きちまう", baseTypes: [WordType.vk], inflectedTypes: [WordType.v5]),
            Inflection(base: "来る", inflection: "来ちまう", baseTypes: [WordType.vk], inflectedTypes: [WordType.v5]),
            Inflection(base: "來る", inflection: "來ちまう", baseTypes: [WordType.vk], inflectedTypes: [WordType.v5]),
        ],
        .shimau: [
            Inflection(base: "て", inflection: "てしまう", baseTypes: [WordType.te_form], inflectedTypes: [WordType.v5]),
            Inflection(base: "で", inflection: "でしまう", baseTypes: [WordType.te_form], inflectedTypes: [WordType.v5]),
        ],
        .nasai: [
            Inflection(base: "る", inflection: "なさい", baseTypes: [WordType.v1], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "う", inflection: "いなさい", baseTypes: [WordType.v5], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "く", inflection: "きなさい", baseTypes: [WordType.v5], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "す", inflection: "しなさい", baseTypes: [WordType.v5], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "つ", inflection: "ちなさい", baseTypes: [WordType.v5], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "ぬ", inflection: "になさい", baseTypes: [WordType.v5], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "ぶ", inflection: "びなさい", baseTypes: [WordType.v5], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "む", inflection: "みなさい", baseTypes: [WordType.v5], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "る", inflection: "りなさい", baseTypes: [WordType.v5], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "ずる", inflection: "じなさい", baseTypes: [WordType.vz], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "する", inflection: "しなさい", baseTypes: [WordType.vs], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "為る", inflection: "為なさい", baseTypes: [WordType.vs], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "くる", inflection: "きなさい", baseTypes: [WordType.vk], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "来る", inflection: "来なさい", baseTypes: [WordType.vk], inflectedTypes: [WordType.nasai_form]),
            Inflection(base: "來る", inflection: "來なさい", baseTypes: [WordType.vk], inflectedTypes: [WordType.nasai_form]),
        ],
        .sou: [
            Inflection(base: "い", inflection: "そう", baseTypes: [WordType.adj_i], inflectedTypes: []),
            Inflection(base: "る", inflection: "そう", baseTypes: [WordType.v1], inflectedTypes: []),
            Inflection(base: "う", inflection: "いそう", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "つ", inflection: "ちそう", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "る", inflection: "りそう", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ぬ", inflection: "にそう", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ぶ", inflection: "びそう", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "む", inflection: "みそう", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "く", inflection: "きそう", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ぐ", inflection: "ぎそう", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "す", inflection: "しそう", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ずる", inflection: "じそう", baseTypes: [WordType.vz], inflectedTypes: []),
            Inflection(base: "する", inflection: "しそう", baseTypes: [WordType.vs], inflectedTypes: []),
            Inflection(base: "為る", inflection: "為そう", baseTypes: [WordType.vs], inflectedTypes: []),
            Inflection(base: "くる", inflection: "きそう", baseTypes: [WordType.vk], inflectedTypes: []),
            Inflection(base: "来る", inflection: "来そう", baseTypes: [WordType.vk], inflectedTypes: []),
            Inflection(base: "來る", inflection: "來そう", baseTypes: [WordType.vk], inflectedTypes: []),
        ],
        .sugiru: [
            Inflection(base: "い", inflection: "すぎる", baseTypes: [WordType.adj_i], inflectedTypes: [WordType.v1]),
            Inflection(base: "る", inflection: "すぎる", baseTypes: [WordType.v1], inflectedTypes: [WordType.v1]),
            Inflection(base: "う", inflection: "いすぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "つ", inflection: "ちすぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "る", inflection: "りすぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ぬ", inflection: "にすぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ぶ", inflection: "びすぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "む", inflection: "みすぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "く", inflection: "きすぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ぐ", inflection: "ぎすぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "す", inflection: "しすぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ずる", inflection: "じすぎる", baseTypes: [WordType.vz], inflectedTypes: [WordType.v1]),
            Inflection(base: "する", inflection: "しすぎる", baseTypes: [WordType.vs], inflectedTypes: [WordType.v1]),
            Inflection(base: "為る", inflection: "為すぎる", baseTypes: [WordType.vs], inflectedTypes: [WordType.v1]),
            Inflection(base: "くる", inflection: "きすぎる", baseTypes: [WordType.vk], inflectedTypes: [WordType.v1]),
            Inflection(base: "来る", inflection: "来すぎる", baseTypes: [WordType.vk], inflectedTypes: [WordType.v1]),
            Inflection(base: "來る", inflection: "來すぎる", baseTypes: [WordType.vk], inflectedTypes: [WordType.v1]),
            
            Inflection(base: "い", inflection: "過ぎる", baseTypes: [WordType.adj_i], inflectedTypes: [WordType.v1]),
            Inflection(base: "る", inflection: "過ぎる", baseTypes: [WordType.v1], inflectedTypes: [WordType.v1]),
            Inflection(base: "う", inflection: "い過ぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "つ", inflection: "ち過ぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "る", inflection: "り過ぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ぬ", inflection: "に過ぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ぶ", inflection: "び過ぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "む", inflection: "み過ぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "く", inflection: "き過ぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ぐ", inflection: "ぎ過ぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "す", inflection: "し過ぎる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ずる", inflection: "じ過ぎる", baseTypes: [WordType.vz], inflectedTypes: [WordType.v1]),
            Inflection(base: "する", inflection: "し過ぎる", baseTypes: [WordType.vs], inflectedTypes: [WordType.v1]),
            Inflection(base: "為る", inflection: "為過ぎる", baseTypes: [WordType.vs], inflectedTypes: [WordType.v1]),
            Inflection(base: "くる", inflection: "き過ぎる", baseTypes: [WordType.vk], inflectedTypes: [WordType.v1]),
            Inflection(base: "来る", inflection: "来過ぎる", baseTypes: [WordType.vk], inflectedTypes: [WordType.v1]),
            Inflection(base: "來る", inflection: "來過ぎる", baseTypes: [WordType.vk], inflectedTypes: [WordType.v1]),
        ],
        .ta: [
            Inflection(base: "い", inflection: "かった", baseTypes: [WordType.adj_i], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "る", inflection: "た", baseTypes: [WordType.v1], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "う", inflection: "った", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "つ", inflection: "った", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "る", inflection: "った", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "ぬ", inflection: "んだ", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "ぶ", inflection: "んだ", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "む", inflection: "んだ", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "く", inflection: "いた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "ぐ", inflection: "いだ", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "す", inflection: "した", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "ずる", inflection: "じた", baseTypes: [WordType.vz], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "する", inflection: "した", baseTypes: [WordType.vs], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "為る", inflection: "為た", baseTypes: [WordType.vs], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "くる", inflection: "きた", baseTypes: [WordType.vk], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "来る", inflection: "来た", baseTypes: [WordType.vk], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "來る", inflection: "來た", baseTypes: [WordType.vk], inflectedTypes: [WordType.ta_form]),
            
            Inflection(base: "いく", inflection: "いった", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "行く", inflection: "行った", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "逝く", inflection: "逝った", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "往く", inflection: "往った", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            
            Inflection(base: "こう", inflection: "こうた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "とう", inflection: "とうた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "請う", inflection: "請うた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "乞う", inflection: "乞うた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "恋う", inflection: "恋うた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "問う", inflection: "問うた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "訪う", inflection: "訪うた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "宣う", inflection: "宣うた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "曰う", inflection: "曰うた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "給う", inflection: "給うた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "賜う", inflection: "賜うた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "揺蕩う", inflection: "揺蕩うた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            
            Inflection(base: "のたまう", inflection: "のたもうた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "たまう", inflection: "たもうた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
            Inflection(base: "たゆたう", inflection: "たゆとうた", baseTypes: [WordType.v5], inflectedTypes: [WordType.ta_form]),
        ],
        .negative: [
            Inflection(base: "い", inflection: "くない", baseTypes: [WordType.adj_i], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "る", inflection: "ない", baseTypes: [WordType.v1], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "う", inflection: "わない", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "く", inflection: "かない", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "ぐ", inflection: "がない", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "す", inflection: "さない", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "つ", inflection: "たない", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "ぬ", inflection: "なない", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "ぶ", inflection: "ばない", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "む", inflection: "まない", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "る", inflection: "らない", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "ずる", inflection: "じない", baseTypes: [WordType.vz], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "する", inflection: "しない", baseTypes: [WordType.vs], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "為る", inflection: "為ない", baseTypes: [WordType.vs], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "くる", inflection: "こない", baseTypes: [WordType.vk], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "来る", inflection: "来ない", baseTypes: [WordType.vk], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "來る", inflection: "來ない", baseTypes: [WordType.vk], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "ます", inflection: "ません", baseTypes: [WordType.masu_form], inflectedTypes: [WordType.masen_form]),
        ],
        .tai: [
            Inflection(base: "る", inflection: "たい", baseTypes: [WordType.v1], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "う", inflection: "いたい", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "く", inflection: "きたい", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "ぐ", inflection: "ぎたい", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "す", inflection: "したい", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "つ", inflection: "ちたい", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "ぬ", inflection: "にたい", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "ぶ", inflection: "びたい", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "む", inflection: "みたい", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "る", inflection: "りたい", baseTypes: [WordType.v5], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "ずる", inflection: "じたい", baseTypes: [WordType.vz], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "する", inflection: "したい", baseTypes: [WordType.vs], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "為る", inflection: "為たい", baseTypes: [WordType.vs], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "くる", inflection: "こたい", baseTypes: [WordType.vk], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "来る", inflection: "来たい", baseTypes: [WordType.vk], inflectedTypes: [WordType.adj_i]),
            Inflection(base: "來る", inflection: "來たい", baseTypes: [WordType.vk], inflectedTypes: [WordType.adj_i]),
        ],
        .tara: [
            Inflection(base: "い", inflection: "かったら", baseTypes: [WordType.adj_i], inflectedTypes: []),
            Inflection(base: "る", inflection: "たら", baseTypes: [WordType.v1], inflectedTypes: []),
            Inflection(base: "う", inflection: "いたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "つ", inflection: "ちたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "る", inflection: "りたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ぬ", inflection: "にたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ぶ", inflection: "びたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "む", inflection: "みたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "く", inflection: "きたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ぐ", inflection: "ぎたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "す", inflection: "したら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ずる", inflection: "じたら", baseTypes: [WordType.vz], inflectedTypes: []),
            Inflection(base: "する", inflection: "したら", baseTypes: [WordType.vs], inflectedTypes: []),
            Inflection(base: "為る", inflection: "為たら", baseTypes: [WordType.vs], inflectedTypes: []),
            Inflection(base: "くる", inflection: "きたら", baseTypes: [WordType.vk], inflectedTypes: []),
            Inflection(base: "来る", inflection: "来たら", baseTypes: [WordType.vk], inflectedTypes: []),
            Inflection(base: "來る", inflection: "來たら", baseTypes: [WordType.vk], inflectedTypes: []),
            Inflection(base: "ます", inflection: "ましたら", baseTypes: [WordType.masu_form], inflectedTypes: []),
            
            Inflection(base: "いく", inflection: "いったら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "行く", inflection: "行ったら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "逝く", inflection: "逝ったら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "往く", inflection: "往ったら", baseTypes: [WordType.v5], inflectedTypes: []),
            
            Inflection(base: "こう", inflection: "こうたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "とう", inflection: "とうたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "請う", inflection: "請うたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "乞う", inflection: "乞うたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "恋う", inflection: "恋うたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "問う", inflection: "問うたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "訪う", inflection: "訪うたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "宣う", inflection: "宣うたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "曰う", inflection: "曰うたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "給う", inflection: "給うたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "賜う", inflection: "賜うたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "揺蕩う", inflection: "揺蕩うたら", baseTypes: [WordType.v5], inflectedTypes: []),
            
            Inflection(base: "のたまう", inflection: "のたもうたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "たまう", inflection: "たもうたら", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "たゆたう", inflection: "たゆとうたら", baseTypes: [WordType.v5], inflectedTypes: []),
        ],
        .tari: [
            Inflection(base: "い", inflection: "かったり", baseTypes: [WordType.adj_i], inflectedTypes: []),
            Inflection(base: "る", inflection: "たり", baseTypes: [WordType.v1], inflectedTypes: []),
            Inflection(base: "う", inflection: "いたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "つ", inflection: "ちたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "る", inflection: "りたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ぬ", inflection: "にたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ぶ", inflection: "びたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "む", inflection: "みたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "く", inflection: "きたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ぐ", inflection: "ぎたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "す", inflection: "したり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "ずる", inflection: "じたり", baseTypes: [WordType.vz], inflectedTypes: []),
            Inflection(base: "する", inflection: "したり", baseTypes: [WordType.vs], inflectedTypes: []),
            Inflection(base: "為る", inflection: "為たり", baseTypes: [WordType.vs], inflectedTypes: []),
            Inflection(base: "くる", inflection: "きたり", baseTypes: [WordType.vk], inflectedTypes: []),
            Inflection(base: "来る", inflection: "来たり", baseTypes: [WordType.vk], inflectedTypes: []),
            Inflection(base: "來る", inflection: "來たり", baseTypes: [WordType.vk], inflectedTypes: []),
            
            Inflection(base: "いく", inflection: "いったり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "行く", inflection: "行ったり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "逝く", inflection: "逝ったり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "往く", inflection: "往ったり", baseTypes: [WordType.v5], inflectedTypes: []),
            
            Inflection(base: "こう", inflection: "こうたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "とう", inflection: "とうたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "請う", inflection: "請うたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "乞う", inflection: "乞うたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "恋う", inflection: "恋うたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "問う", inflection: "問うたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "訪う", inflection: "訪うたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "宣う", inflection: "宣うたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "曰う", inflection: "曰うたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "給う", inflection: "給うたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "賜う", inflection: "賜うたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "揺蕩う", inflection: "揺蕩うたり", baseTypes: [WordType.v5], inflectedTypes: []),
            
            Inflection(base: "のたまう", inflection: "のたもうたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "たまう", inflection: "たもうたり", baseTypes: [WordType.v5], inflectedTypes: []),
            Inflection(base: "たゆたう", inflection: "たゆとうたり", baseTypes: [WordType.v5], inflectedTypes: []),
        ],
        .causative: [
            Inflection(base: "る", inflection: "させる", baseTypes: [WordType.v1], inflectedTypes: [WordType.v1]),
            Inflection(base: "う", inflection: "あせる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "つ", inflection: "たせる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "る", inflection: "らせる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ぬ", inflection: "なせる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ぶ", inflection: "ばせる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "む", inflection: "ませる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "く", inflection: "かせる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "ぐ", inflection: "がせる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            Inflection(base: "す", inflection: "させる", baseTypes: [WordType.v5], inflectedTypes: [WordType.v1]),
            
            Inflection(base: "ずる", inflection: "じさせる", baseTypes: [WordType.vz], inflectedTypes: [WordType.v1]),
            Inflection(base: "ずる", inflection: "ぜさせる", baseTypes: [WordType.vz], inflectedTypes: [WordType.v1]),
            Inflection(base: "する", inflection: "させる", baseTypes: [WordType.vs], inflectedTypes: [WordType.v1]),
            Inflection(base: "する", inflection: "せさせる", baseTypes: [WordType.vs], inflectedTypes: [WordType.v1]),
            Inflection(base: "為る", inflection: "為せる", baseTypes: [WordType.vs], inflectedTypes: [WordType.v1]),
            Inflection(base: "為る", inflection: "為させる", baseTypes: [WordType.vs], inflectedTypes: [WordType.v1]),
            Inflection(base: "くる", inflection: "こさせる", baseTypes: [WordType.vk], inflectedTypes: [WordType.v1]),
            Inflection(base: "来る", inflection: "来させる", baseTypes: [WordType.vk], inflectedTypes: [WordType.v1]),
            Inflection(base: "來る", inflection: "來させる", baseTypes: [WordType.vk], inflectedTypes: [WordType.v1]),
        ],
        .short_causative: [
            Inflection(base: "る", inflection: "さす", baseTypes: [WordType.v1], inflectedTypes: [WordType.v5ss]),
            Inflection(base: "う", inflection: "わす", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5sp]),
            Inflection(base: "つ", inflection: "たす", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5sp]),
            Inflection(base: "る", inflection: "らす", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5sp]),
            Inflection(base: "ぬ", inflection: "なす", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5sp]),
            Inflection(base: "ぶ", inflection: "ばす", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5sp]),
            Inflection(base: "む", inflection: "ます", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5sp]),
            Inflection(base: "く", inflection: "かす", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5sp]),
            Inflection(base: "ぐ", inflection: "がす", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5sp]),
            Inflection(base: "す", inflection: "さす", baseTypes: [WordType.v5], inflectedTypes: [WordType.v5ss]),
            
            Inflection(base: "ずる", inflection: "じさす", baseTypes: [WordType.vz], inflectedTypes: [WordType.v5ss]),
            Inflection(base: "ずる", inflection: "ぜさす", baseTypes: [WordType.vz], inflectedTypes: [WordType.v5ss]),
            Inflection(base: "する", inflection: "さす", baseTypes: [WordType.vs], inflectedTypes: [WordType.v5ss]),
            Inflection(base: "為る", inflection: "為す", baseTypes: [WordType.vs], inflectedTypes: [WordType.v5ss]),
            Inflection(base: "くる", inflection: "こさす", baseTypes: [WordType.vk], inflectedTypes: [WordType.v5ss]),
            Inflection(base: "来る", inflection: "来さす", baseTypes: [WordType.vk], inflectedTypes: [WordType.v5ss]),
            Inflection(base: "來る", inflection: "來さす", baseTypes: [WordType.vk], inflectedTypes: [WordType.v5ss]),
        ],
        .ku: [
            Inflection(base: "い", inflection: "く", baseTypes: [.adj_i], inflectedTypes: [.ku_form])
        ]
        
    ]
    
    public func match(text: String) -> Bool {
        return text.hasSuffix(self.inflection)
    }
    
    public static func deinflect(text: String) -> [Deinflection] {
        var deinflections: [Deinflection] = [Deinflection(text: text, inflections: [], types: [])]
        
        var i = 0
        while i < deinflections.count {
            let current_deinflection = deinflections[i]
            for (ruleName, inflections) in Inflection.inflectionRules {
                for inflection in inflections {
                    if (current_deinflection.types.isEmpty || current_deinflection.types == inflection.inflectedTypes) && inflection.match(text: current_deinflection.text) {
                        
                        let newText = String(current_deinflection.text.dropLast(inflection.inflection.count)) + inflection.base
                        var newInflections = current_deinflection.inflections
                        newInflections.append(ruleName)
                        let newTypes = inflection.baseTypes
                        
                        deinflections.append(Deinflection(text: newText, inflections: newInflections, types: newTypes))
                    }
                }
            }
            i += 1
        }
        
        return deinflections
    }
    
}


public struct Deinflection : Hashable {
    
    public let text: String
    public let inflections: [InflectionRule]
    public let types: [WordType]
    
}
