"use strict";

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
                res.set("content-type", resp.headers["content-type"]);
                res.end(resp.text);
            }
        });
}

function onErr (err, req, res, next) {
    throw err;
}

api.listen(3000)
