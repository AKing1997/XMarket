var XMarketCoin = artifacts.require("./XMarketCoin.sol");

module.exports = function(deployer) {
  deployer.deploy(XMarketCoin);
};
