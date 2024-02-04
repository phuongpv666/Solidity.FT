// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TicTacToe {
    function isWinning(uint8[3][3] memory board) public pure returns (bool) {
        // Check rows and columns
        for (uint8 i = 0; i < 3; i++) {
            if (
                (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != 0) ||
                (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != 0)
            ) {
                return true;
            }
        }

        // Check diagonals
        if (
            (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != 0) ||
            (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != 0)
        ) {
            return true;
        }

        // No winner found
        return false;
    }
}

//Array  [[1, 1, 0], 
      //   [0, 1, 0],
    //    [1, 0, 1]]
       //Please input: [[1, 1, 0], [0, 1, 0], [1, 0, 1]]