import * as Eos from 'eosjs';

const producerAccount = 'inita';
const producerPrivate = '5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3';
const producerPublic = 'EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV';

const eos = Eos.Testnet({ keyProvider: producerPrivate });

const accountName = 'tictactoe';

const fs = require('fs');
const contractCode = fs.readFileSync(__dirname + '/../contracts/tic_tac_toe.wast', 'utf8');
const contractAbi = fs.readFileSync(__dirname + '/../contracts/tic_tac_toe.abi', 'utf8');

(window as any).contractCode = contractCode;
(window as any).contractAbi = contractAbi;

async function ensureAccount() {
    try {
        await eos.getAccount(accountName);
        console.log('Account name exists:', accountName);
    } catch (e) {
        try {
            await eos.newaccount({
                creator: producerAccount,
                name: accountName,
                owner: producerPublic,
                active: producerPublic,
                recovery: producerAccount,
                deposit: '1 EOS',
            });
            await eos.getAccount(accountName);
            console.log('Created account:', accountName);
        } catch (error) {
            console.error('Error creating account:', { error, accountName });
        }
    }
}

async function ensureContract() {
    try {
        await eos.contract(accountName);
        console.log('Contract exists:', accountName);
    } catch (e) {

        try {
            await eos.setcode({
                account: accountName,
                vm_type: 0,
                vm_version: 0,
                code: contractCode,
                code_abi: contractAbi,
            });
            console.log('Contract created:', { accountName, contractCode, contractAbi });
        } catch (error) {
            console.error('Error creating contract:', { error, accountName, contractCode, contractAbi });
        }
    }
}

(window as any).Eos = Eos;
(window as any).eos = eos;

window.addEventListener('load', async () => {
    await ensureAccount();
    await ensureContract();
    const Elm = require('../elm/Main');
    Elm.Main.fullscreen({
        contractAccount: 'tic.tac.toe',
        contractCode,
        contractAbi,
    });
});

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
