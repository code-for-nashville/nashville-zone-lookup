"use strict";

const _40 = 40;
const _30 = 30;
const _20 = 20;
const _15 = 15;
const _10 = 10;
const _5  = 5;
const _0  = 0;

const zones = {
    "single-family": {
        "ag":        {
            "minor-local-local": _40,
            "all-other": _40
        },
        "ar2a":      {
            "minor-local-local": _40,
            "all-other": _40
        },
        "rs80":      {
            "minor-local-local": _40,
            "all-other": _40
        },
        "r80":       {
            "minor-local-local": _40,
            "all-other": _40
        },
        "rs40":      {
            "minor-local-local": _40,
            "all-other": _40
        },
        "r40":       {
            "minor-local-local": _40,
            "all-other": _40
        },

        "rs30,":     {
            "minor-local-local": _30,
            "all-other": _40
        },
        "r30,":      {
            "minor-local-local": _30,
            "all-other": _40
        },
        "rs20,":     {
            "minor-local-local": _30,
            "all-other": _40
        },
        "r20,":      {
            "minor-local-local": _30,
            "all-other": _40
        },
        "rs15,":     {
            "minor-local-local": _30,
            "all-other": _40
        },
        "r15,":      {
            "minor-local-local": _30,
            "all-other": _40
        },
        "rm2":       {
            "minor-local-local": _30,
            "all-other": _40
        },

        "rs10":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "r10":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "r8":        {
            "minor-local-local": _20,
            "all-other": _40
        },
        "r8-a":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rs7.5":     {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rs7.5-a":   {
            "minor-local-local": _20,
            "all-other": _40
        },
        "r6":        {
            "minor-local-local": _20,
            "all-other": _40
        },
        "r6-a":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rs5":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rs5-a":     {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rs3.75":    {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rs3.75-a":  {
            "minor-local-local": _20,
            "all-other": _40
        },
        "mhp":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm4":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm4":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm5":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm6":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm7":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm8":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm9":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm10":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm11":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm12":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm13":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm14":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm15":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm16":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm17":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm18":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm19":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm20":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm21":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm22":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm23":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm24":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm25":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm26":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm27":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm28":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm29":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm30":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm31":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm32":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm33":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm34":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm35":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm36":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm37":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm38":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm39":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm40":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm41":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm42":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm43":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm44":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm45":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm46":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm47":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm48":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm49":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm50":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm51":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm52":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm53":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm54":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm55":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm56":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm57":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm58":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm59":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "rm60":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "mun":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "mul":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "mug":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "mui":       {
            "minor-local-local": _20,
            "all-other": _40
        },
        "on":        {
            "minor-local-local": _20,
            "all-other": _40
        },
        "or20":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "or40":      {
            "minor-local-local": _20,
            "all-other": _40
        },
        "ori":       {
            "minor-local-local": _20,
            "all-other": _40
        },

        "sp":        "Street setbacks shall be as specifically listed in the site specific SP ordinance",
        "dtc":        "See  Chapter 17.37",

        "rm9-a":     {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm10-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm11-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm12-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm13-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm14-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm15-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm16-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm17-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm18-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm19-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm20-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm21-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm22-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm23-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm24-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm25-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm26-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm27-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm28-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm29-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm30-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm31-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm32-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm33-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm34-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm35-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm36-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm37-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm38-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm39-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm40-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm41-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm42-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm43-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm44-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm45-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm46-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm47-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm48-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm49-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm50-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm51-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm52-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm53-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm54-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm55-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm56-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm57-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm58-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm59-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm60-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm61-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm62-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm63-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm64-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm65-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm66-a":    {
            "minor-local-local": _5,
            "all-other": _5
        },
        "rm67-a":    {
            "minor-local-local": _5,
            "all-other": _5
            },
            "rm68-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm69-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm70-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm71-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm72-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm73-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm74-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm75-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm76-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm77-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm78-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm79-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm80-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm81-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm82-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm83-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm84-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm85-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm86-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm87-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm88-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm89-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm90-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm91-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm92-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm93-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm94-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm95-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm96-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm97-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm98-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm99-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "rm100-a":   {
                "minor-local-local": _5,
                "all-other": _5
            },
    
            "mun-a":     {
                "minor-local-local": _5,
                "all-other": _5
            },
            "mul-a":     {
                "minor-local-local": _5,
                "all-other": _5
            },
            "mug-a":     {
                "minor-local-local": _5,
                "all-other": _5
            },
            "mui-a":     {
                "minor-local-local": _5,
                "all-other": _5
            },
            "or20-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "or40-a":    {
                "minor-local-local": _5,
                "all-other": _5
            },
            "ori-a":     {
                "minor-local-local": _5,
                "all-other": _5
            },
        },

        "multi-family": {
            "ag": _40,

            // .. ag - rm15 (whatever that means)
            "rm15": _40,

            "rm20": _30,
            "rm40": _30,

            "on":    _20,
            "ol":    _20,
            "og":    _20,
            "or20":  _20,
            "or40":  _20,

            "rm60":  _10,
            "mun":   _10,
            "mul":   _10,
            "mug":   _10,
            "ori":   _10,

            "cn":    _20,
            "cn-a":  _20,
            "scn":   _20,
            "scc":   _20,
            "scr":   _20,

            "cl":    _15,
            "cl-a":  _15,
            "cs":    _15,
            "cs-a":  _15,
            "ca":    _15,

            "iwd":   _5,
            "ir":    _5,
            "ig":    _5,

            "cf":    _0,
            "mui":   _0,

            "dtc":   "See chapter 17.37" // need href
        }
}

module.exports = zones;
