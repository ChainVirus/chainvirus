import "dotenv/config"
import { HardhatUserConfig } from "hardhat/config"
import "@nomicfoundation/hardhat-toolbox"
import "hardhat-gas-reporter"
import "@nomicfoundation/hardhat-ignition-ethers";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.23",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000,
      },
    },
  },
  gasReporter: {
    currency: "USD",
    gasPrice: 21,
    enabled: true,
  },
  networks: {
    arb: {
      url: `https://arb-mainnet.g.alchemy.com/v2/${process.env.PUBLIC_ALCHEMY_ID}`,
      accounts: [process.env.DEPLOY_PRIVATE_KEY!],
    }
    // sepolia: {
    //   url: `https://eth-sepolia.g.alchemy.com/v2/${process.env.ALCHEMY_API_KEY}`,
    //   accounts: [process.env.SEPOLIA_PRIVATE_KEY_1],
    // },
  },
}

export default config
