const Merkle = artifacts.require("Merkle");

module.exports = function (deployer) {
  deployer.deploy(Merkle);
};
