"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Eos = require("eosjs");
var ecc = Eos.modules.ecc;
function callSync(r) {
    var response = ecc[r.method].apply(ecc, r.params);
    var result = r.toResult(JSON.stringify(response));
    console.log('ecc.callSync', r, result);
    return result._0;
}
global._user$project$Native_Eos_Ecc = {
    callSync: callSync,
};
