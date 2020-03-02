pragma solidity >=0.4.25 <0.7.0;

/*
Implements EIP20 token standard: https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
.*/


import "./EIP20Interface.sol";
import "./WhiteList.sol";

contract EIP20 is EIP20Interface   {

    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;
    /*
    NOTE:
    The following variables are OPTIONAL vanities. One does not have to include them.
    They allow one to customise the token contract & in no way influences the core functionality.
    Some wallets/interfaces might not even bother to look at this information.
    */
    string public name;                   //fancy name: eg Simon Bucks
    uint8 public decimals;                //How many decimals to show.
    string public symbol;                 //An identifier: eg SBX

    constructor(
        uint256 _initialAmount,
        string memory _tokenName, //Don't forget to add memory in order to store strings
        uint8 _decimalUnits,
        string memory _tokenSymbol
    ) public {
        balances[msg.sender] = _initialAmount;               // Give the creator all initial tokens
        totalSupply = _initialAmount;                        // Update total supply
        name = _tokenName;                                   // Set the name for display purposes
        decimals = _decimalUnits;                            // Amount of decimals for display purposes
        symbol = _tokenSymbol;                               // Set the symbol for display purposes
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        //require(userAdress[_to] = true,"");
        require(balances[msg.sender] >= _value, "");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        //require(userAdress[_from] = true,"");
        //require(userAdress[_to] = true,"");
        require(balances[_from] >= _value && allowance >= _value, "");
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        emit Transfer(_from, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }
    function MultiDistribution(address _to, uint _level) public returns (bool success)
    {
        uint _value;
        require(_level > 0 && _level <= 3,"Select a level : 1,2 or 3");
        if(_level == 1){
            _value = 20;
        }
        else if(_level == 2){
            _value = 40;
        }
        else if(_level == 3){
            _value = 80;
        }
        //require(userAdress[_to] = true,"");
        require(balances[msg.sender] >= _value, "");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        //require(userAdress[_owner] = true,"");
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        //require(userAdress[_spender] = true,"");
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value); //solhint-disable-line indent, no-unused-vars
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        //require(userAdress[_owner] = true,"");
        //require(userAdress[_spender] = true,"");
        return allowed[_owner][_spender];
    }
}