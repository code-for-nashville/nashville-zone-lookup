"use strict";

const zones = require("./zones.js");

const path = require("path");
const request = require("superagent");
const express = require("express");
const api = express();

let ZONING_HISTORY_ENDPOINT = 'http://maps.nashville.gov/ParcelService/Search.asmx/GetZoningHistory?onlyactive=false';

api.use(express.static(path.join(__dirname, "static")));
api.get("/api/zoningHistory", getZoningHistory);

api.use(onErr);

function getZoningHistory (req, res, next) {
    console.log("REQUEST")
    let parId = req.query.pin;

    console.log(parId);

    request(ZONING_HISTORY_ENDPOINT)
        .query({ pin: parId })
        .end((err, resp) => {
            if (err) {
                console.log("error");
                res.statusCode = 400;
                res.json(err);

            } else {
                console.log("good");

                res.set("content-type", "application/json");

                const zoneInfo = parseZoneData(resp.text)

                res.json(zoneInfo);
            }
        });
}

function onErr (err, req, res, next) {
    throw err;
}

/**
 * Given the sample below, parse out Zoning, Description, Ordinance
 * and return as an object
 *
 * Will set null for properties not found in the Zoning xml
 */
function parseZoneData (text) {
   /*
    * <ZoningInfo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    * xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    * xmlns="http://maps.nashville.gov">
    * <anyType xsi:type="ZoningInfo">
        * <Zoning>IR</Zoning>
        * <EffectiveDate>12/24/1974</EffectiveDate>
        * <Description>Industrial Restrictive is intended for a wide range of
        * light manufacturing uses at moderate intensities within enclosed
        * structures.</Description>
        * <CaseNumber />
        * <Ordinance>O73-650</Ordinance>
        * <OrdinanceHref>O73-650</OrdinanceHref>
        * <Status>Current</Status>
        * <PIN>74859</PIN>
    * </anyType>
    * </ZoningInfo>
    *
    * We want the Zoning element
    */

    let reZone = /<zoning>(.+)<\/zoning>/i;
    let res = reZone.exec(text);

    let reDesc = /<description>(.+)<\/description>/i;
    let dRes = reDesc.exec(text);

    let reOrd = /<ordinance>(.+)<\/ordinance>/i;
    let oRes = reOrd.exec(text);

    const zoneInfo =  {
        zoning: res && res[1],
        description: dRes && dRes[1],
        ordinance: oRes && oRes[1],
    };

    const zoneCode = zoneInfo.zoning && zoneInfo.zoning.toLowerCase() || null;
    console.log(zones[zoneCode]);

    const single = zones["single-family"];
    const multi = zones["multi-family"];

    zoneInfo.single = single[zoneCode] || null
    zoneInfo.multi = multi[zoneCode] || null;

    zoneInfo.setBackUnit = "ft";

    return zoneInfo;
}

api.listen(3000)
