const path = require("path");
const fs = require("fs");
const solc = require("solc");

const contractPath = path.resolve(__dirname, "contracts", "UserRegistry.sol");
const source = fs.readFileSync(contractPath, "utf8");

// Derleme işlemi için gerekli olan input nesnesini oluşturun
const input = {
  language: "Solidity",
  sources: {
    "UserRegistry.sol": {
      content: source,
    },
  },
  settings: {
    outputSelection: {
      "*": {
        "*": ["*"],
      },
    },
  },
};

// solc.compile ile derleme işlemini gerçekleştirin
const output = JSON.parse(solc.compile(JSON.stringify(input)));

// Contracts objesini doğrudan export edin
module.exports = {
  interface: output.contracts["UserRegistry.sol"].UserRegistry.abi,
  bytecode: output.contracts["UserRegistry.sol"].UserRegistry.evm.bytecode.object,
};




