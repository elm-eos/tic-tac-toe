import * as Eos from 'eosjs';

const nativeBinding = _elm_lang$core$Native_Scheduler.nativeBinding;
const succeed = _elm_lang$core$Native_Scheduler.succeed;
const fail = _elm_lang$core$Native_Scheduler.fail;

function eosError(e) {
    return { ctor: 'Error', _0: e };
}

interface EosConfig {
    httpEndpoint: string;
    apiLog?: any;
    keyProvider?: string;
}

function request(r) {
    return nativeBinding(async callback => {
        const httpEndpoint = r.httpEndpoint;
        const config: EosConfig = {
            httpEndpoint: r.httpEndpoint,
            apiLog: null,
        };

        const privateKeys = r.privateKeys._0;
        if (privateKeys) {
            config.keyProvider = privateKeys._0;
        }
        // console.log(config);
        const eos = Eos.Testnet(config);

        if (!(r.method in eos)) {
            return callback(fail(eosError(`Undefined method "${r.method}"`)));
        }

        if (r.method === 'transaction') {
            // To avoid errors about Abi caching
            try {
                // console.log(r.params);
                const code = r.params[0].messages[0].code;
                await eos.contract(code);
            } catch (err) {
                return callback(fail(eosError(err.message)));
            }
        }

        try {
            const response = await eos[r.method].apply(eos, r.params);
            const result = r.toResult(JSON.stringify(response));
            switch (result.ctor) {
                case 'Ok':
                    return callback(succeed(result._0));
                case 'Err':
                    return callback(fail(eosError(result._0)));
            }
        } catch (err) {
            return callback(fail(eosError(err.message)));
        }
    });
}

(global as any)._user$project$Native_Eos = {
    request,
};
