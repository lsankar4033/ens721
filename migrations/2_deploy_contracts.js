var ENS721 = artifacts.require("ENS721");

module.exports = (deployer, network) => {
  deployer.deploy(ENS721);
};
