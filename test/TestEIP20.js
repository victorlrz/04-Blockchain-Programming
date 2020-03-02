var EIP20 = artifacts.require("EIP20");

contract('EIP20',(accounts) =>{
    it('should put 50000 token in the first account', async () => {
        const eip20Instance = await EIP20.deployed();
        const balance = await eip20Instance.balanceOf.call(accounts[0]);

        assert.equal(balance.valueOf(), 50000, "50000 wasn't in the first account");
    });
    it('should send coin correctly', async () => {
        const eip20Instance = await EIP20.deployed();
    
        // Setup 2 accounts.
        const accountOne = accounts[0];
        const accountTwo = accounts[1];
    
        // Get initial balances of first and second account.
        const accountOneStartingBalance = (await eip20Instance.balanceOf.call(accountOne)).toNumber();
        const accountTwoStartingBalance = (await eip20Instance.balanceOf.call(accountTwo)).toNumber();
    
        // Make transaction from first account to second.
        const amount = 100;
        await eip20Instance.transfer(accountTwo, amount, { from: accountOne });
    
        // Get balances of first and second account after the transactions.
        const accountOneEndingBalance = (await eip20Instance.balanceOf.call(accountOne)).toNumber();
        const accountTwoEndingBalance = (await eip20Instance.balanceOf.call(accountTwo)).toNumber();

        assert.equal(accountOneEndingBalance, accountOneStartingBalance - amount, "Amount wasn't correctly taken from the sender");
        assert.equal(accountTwoEndingBalance, accountTwoStartingBalance + amount, "Amount wasn't correctly sent to the receiver");
      });
      it('should send coin correctly (transferFrom)', async () => {
        const eip20Instance = await EIP20.deployed();
    
        // Setup 2 accounts.
        const accountOne = accounts[1];
        const accountTwo = accounts[2];
        //eip20Instance.allowance.call(accountOne,accountTwo);
    
        // Get initial balances of first and second account.
        const accountOneStartingBalance = (await eip20Instance.balanceOf.call(accountOne)).toNumber();
        const accountTwoStartingBalance = (await eip20Instance.balanceOf.call(accountTwo)).toNumber();
    
        // Make transaction from first account to second.
        const amount = 100;
        await eip20Instance.transferFrom(accountOne, accountTwo, amount);
    
        // Get balances of first and second account after the transactions.
        const accountOneEndingBalance = (await eip20Instance.balanceOf.call(accountOne)).toNumber();
        const accountTwoEndingBalance = (await eip20Instance.balanceOf.call(accountTwo)).toNumber();

        assert.equal(accountOneEndingBalance, accountOneStartingBalance - amount, "Amount wasn't correctly taken from the sender");
        assert.equal(accountTwoEndingBalance, accountTwoStartingBalance + amount, "Amount wasn't correctly sent to the receiver");
      });

});