/**
 *  @file
 *  @copyright defined in eos/LICENSE.txt
 */
#include <eoslib/eos.hpp>
#include <eoslib/db.hpp>

/**
 *  @defgroup tictactoecontract Tic Tac Toe Contract
 *  @brief Defines the PvP tic tac toe contract example
 *  @ingroup examplecontract
 *  
 *  @details
 *
 *  For the following tic-tac-toe game:
 *  - Each pair of player can have 2 unique game, one where player_1 become host and player_2 become challenger and vice versa
 *  - The game data is stored in the "host" scope and use the "challenger" as the key
 *  
 *  (0,0) coordinate is on the top left corner of the board
 *  @code
 *                 (0,2)
 *  (0,0) -  |  o  |  x      where - = empty cell
 *        -  |  x  |  -            x = move by host
 *  (2,0) x  |  o  |  o            o = move by challenger
 *  @endcode
 * 
 *  Board is represented with number:
 *  - 0 represents empty cell
 *  - 1 represents cell filled by host 
 *  - 2 represents cell filled by challenger
 *  Therefore, assuming x is host, the above board will have the following representation: [0, 2, 1, 0, 1, 0, 1, 2, 2] inside the game object
 * 
 *  In order to deploy this contract:
 *  - Create an account called tic.tac.toe
 *  - Add tic.tac.toe key to your wallet
 *  - Set the contract on the tic.tac.toe account
 * 
 *  How to play the game:
 *  - Create a game using `create` action, with you as the host and other account as the challenger.
 *  - The first move needs to be done by the host, use the `move` action to make a move by specifying which row and column to fill.
 *  - Then ask the challenger to make a move, after that it's back to the host turn again, repeat until the winner is determined.
 *  - If you want to restart the game, use the `restart` action
 *  - If you want to clear the game from the database to save up some space after the game has ended, use the `close` action
 *  @{
 */

using namespace eosio;
namespace tic_tac_toe {
  /**
   * @brief Data structure to hold game information
   */
  struct PACKED(game) {
    game() {};
    game(account_name challenger, account_name host):challenger(challenger), host(host), turn(host) {
      // Initialize board
      initialize_board();
    };
    account_name     challenger; // this also acts as key of the table
    account_name     host;
    account_name     turn; // = account name of host/ challenger
    account_name     winner = N(none); // = none/ draw/ account name of host/ challenger
    uint8_t          board_len = 9;
    uint8_t          board[9]; //
    
    // Initialize board with empty cell
    void initialize_board() {
      for (uint8_t i = 0; i < board_len ; i++) {
        board[i] = 0;
      }
    }

    // Reset game
    void reset_game() {
      initialize_board();
      turn = host;
      winner = N(none);
    }
  };

  /**
   * @brief Data structure to hold game information
   */
  struct PACKED(invite) {
    invite() {};
    invite(account_name challenger, account_name host):challenger(challenger), host(host) { };
    account_name     challenger; // this also acts as key of the table
    account_name     host;
  };

  /**
   * @brief Action to create new game
   */ 
  struct create {
    account_name   challenger;
    account_name   host;
  };

  /**
   * @brief Action to restart new game
   */ 
  struct restart {
    account_name   challenger;
    account_name   host;
    account_name   by; // the account who wants to restart the game
  };

  /**
   * @brief Action to close new game
   */ 
  struct close {
    account_name   challenger;
    account_name   host;
  };

  /**
   * @brief Data structure for movement
   */ 
  struct movement {
    uint32_t    row;
    uint32_t    column;
  };

  /**
   * @brief Action to make movement
   */ 
  struct move {
    account_name   challenger;
    account_name   host;
    account_name   by; // the account who wants to make the move
    movement       mvt;
  };

  /**
   * @brief table to store list of games
   */ 
  using Games = eosio::table<N(tic.tac.toe),N(tic.tac.toe),N(games),game,uint64_t>;

  /**
   * @brief table to store list of invites
   */ 
  using Invites = eosio::table<N(tic.tac.toe),N(tic.tac.toe),N(invites),invite,uint64_t>;
}
/// @}
