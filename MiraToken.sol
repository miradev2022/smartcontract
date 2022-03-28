pragma solidity ^0.4.25;

import "./MintableToken.sol";
import "./BurnableToken.sol";
import "./Pausable.sol";
import "./FreezableMintableToken.sol";


contract Consts {
    uint public constant TOKEN_DECIMALS = 18;
    uint8 public constant TOKEN_DECIMALS_UINT8 = 18;
    uint public constant TOKEN_DECIMAL_MULTIPLIER = 10 ** TOKEN_DECIMALS;

    string public constant TOKEN_NAME = "MIRA";
    string public constant TOKEN_SYMBOL = "MIRA";
    bool public constant PAUSED = false;
    address public constant TARGET_USER = 0x5d4C83C3d283056ae6F51130F8DD9dC41462f358;
    bool public constant CONTINUE_MINTING = true;
}


contract MIRATOKEN is Consts, FreezableMintableToken, BurnableToken, Pausable {
    event Initialized();
    bool public initialized = false;

    constructor() public {
        init();
        
    }

    function name() public pure returns (string) {
        return TOKEN_NAME;
    }

    function symbol() public pure returns (string) {
        return TOKEN_SYMBOL;
    }

    function decimals() public pure returns (uint8) {
        return TOKEN_DECIMALS_UINT8;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool _success) {
        require(!paused);
        return super.transferFrom(_from, _to, _value);
    }

    function transfer(address _to, uint256 _value) public returns (bool _success) {
        require(!paused);
        return super.transfer(_to, _value);
    }

    function init() private {
        require(!initialized);
        initialized = true;

        if (PAUSED) {
            pause();
        }


        if (!CONTINUE_MINTING) {
            finishMinting();
        }

        emit Initialized();
    }
}
