var EIP20 = artifacts.require("EIP20");

module.exports = function(deployer) {
  deployer.deploy(EIP20,50000,"EOS",3,"Fire");
};