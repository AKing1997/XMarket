const DigitalIdentity = artifacts.require("./DigitalIdentity.sol");
const RealEstateToken = artifacts.require("./RealEstateToken.sol");
const RealEstateAsset = artifacts.require("./RealEstateAsset.sol");
const Market = artifacts.require("./Market.sol");

module.exports = async function(deployer) {
    await deployer.deploy(DigitalIdentity);
    const digitalIdentityInstance = await DigitalIdentity.deployed();

    await deployer.deploy(RealEstateToken, digitalIdentityInstance.address);
    const realEstateTokenInstance = await RealEstateToken.deployed();

    await deployer.deploy(RealEstateAsset, digitalIdentityInstance.address);
    const realEstateAssetInstance = await RealEstateAsset.deployed();


    await deployer.deploy(
      Market, 
      realEstateAssetInstance.address, 
      realEstateTokenInstance.address, 
      digitalIdentityInstance.address
    );
};
