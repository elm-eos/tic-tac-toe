"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = y[op[0] & 2 ? "return" : op[0] ? "throw" : "next"]) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [0, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var _this = this;
Object.defineProperty(exports, "__esModule", { value: true });
var Eos = require("eosjs");
var producerAccount = 'inita';
var producerPrivate = '5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3';
var producerPublic = 'EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV';
var eos = Eos.Testnet({ keyProvider: producerPrivate });
var accountName = 'tictactoe';
var fs = require('fs');
var contractCode = fs.readFileSync(__dirname + '/../contracts/tic_tac_toe.wast', 'utf8');
var contractAbi = fs.readFileSync(__dirname + '/../contracts/tic_tac_toe.abi', 'utf8');
window.contractCode = contractCode;
window.contractAbi = contractAbi;
function ensureAccount() {
    return __awaiter(this, void 0, void 0, function () {
        var e_1, error_1;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    _a.trys.push([0, 2, , 8]);
                    return [4 /*yield*/, eos.getAccount(accountName)];
                case 1:
                    _a.sent();
                    console.log('Account name exists:', accountName);
                    return [3 /*break*/, 8];
                case 2:
                    e_1 = _a.sent();
                    _a.label = 3;
                case 3:
                    _a.trys.push([3, 6, , 7]);
                    return [4 /*yield*/, eos.newaccount({
                            creator: producerAccount,
                            name: accountName,
                            owner: producerPublic,
                            active: producerPublic,
                            recovery: producerAccount,
                            deposit: '1 EOS',
                        })];
                case 4:
                    _a.sent();
                    return [4 /*yield*/, eos.getAccount(accountName)];
                case 5:
                    _a.sent();
                    console.log('Created account:', accountName);
                    return [3 /*break*/, 7];
                case 6:
                    error_1 = _a.sent();
                    console.error('Error creating account:', { error: error_1, accountName: accountName });
                    return [3 /*break*/, 7];
                case 7: return [3 /*break*/, 8];
                case 8: return [2 /*return*/];
            }
        });
    });
}
function ensureContract() {
    return __awaiter(this, void 0, void 0, function () {
        var e_2, error_2;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    _a.trys.push([0, 2, , 7]);
                    return [4 /*yield*/, eos.contract(accountName)];
                case 1:
                    _a.sent();
                    console.log('Contract exists:', accountName);
                    return [3 /*break*/, 7];
                case 2:
                    e_2 = _a.sent();
                    _a.label = 3;
                case 3:
                    _a.trys.push([3, 5, , 6]);
                    return [4 /*yield*/, eos.setcode({
                            account: accountName,
                            vm_type: 0,
                            vm_version: 0,
                            code: contractCode,
                            code_abi: contractAbi,
                        })];
                case 4:
                    _a.sent();
                    console.log('Contract created:', { accountName: accountName, contractCode: contractCode, contractAbi: contractAbi });
                    return [3 /*break*/, 6];
                case 5:
                    error_2 = _a.sent();
                    console.error('Error creating contract:', { error: error_2, accountName: accountName, contractCode: contractCode, contractAbi: contractAbi });
                    return [3 /*break*/, 6];
                case 6: return [3 /*break*/, 7];
                case 7: return [2 /*return*/];
            }
        });
    });
}
window.Eos = Eos;
window.eos = eos;
window.addEventListener('load', function () { return __awaiter(_this, void 0, void 0, function () {
    var Elm;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0: return [4 /*yield*/, ensureAccount()];
            case 1:
                _a.sent();
                return [4 /*yield*/, ensureContract()];
            case 2:
                _a.sent();
                Elm = require('../elm/Main');
                Elm.Main.fullscreen({
                    contractAccount: 'tic.tac.toe',
                    contractCode: contractCode,
                    contractAbi: contractAbi,
                });
                return [2 /*return*/];
        }
    });
}); });
// eos.transaction({
//     scope: ['inita', 'initb'],
//     messages: [
//         {
//             code: 'tictactoe',
//             type: 'move',
//             authorization: [{
//                 account: 'inita',
//                 permission: 'active'
//             }],
//             data: {
//                 host: 'inita',
//                 challenger: 'initb',
//                 by: 'inita',
//                 movement: {
//                     row: 0,
//                     column: 0,
//                 }
//             }
//         }
//     ]
// })
