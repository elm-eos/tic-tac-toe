import * as Eos from 'eosjs';

const ecc = Eos.modules.ecc;

function callSync(r) {
    const response = ecc[r.method].apply(ecc, r.params);
    const result = r.toResult(JSON.stringify(response));
    console.log('ecc.callSync', r, result);
    return result._0;
}

(global as any)._user$project$Native_Eos_Ecc = {
    callSync,
};
