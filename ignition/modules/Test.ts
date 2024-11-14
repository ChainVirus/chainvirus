import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("Pandora4", (m) => {
    const name = "Pandora3";
    const symbol = "Pandora3";
    const mu_ = 1;
    const maxTotalSupplyERC721_ = 100;
    // 总代币量是 maxTotalSupplyERC721_ * 10^mu_
    const initialOwner_ = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
    const initialMintRecipient_ = "0xe17ac42fdfdd0aca51e0e2a8908af77fb54cf0c9";

    const apollo = m.contract("ERC404Example", [name, symbol, mu_, maxTotalSupplyERC721_, initialOwner_, initialMintRecipient_]);

    m.call(apollo, "setDataURI", ["https://raw.githubusercontent.com/0xacme/pandora/main/"]);

    return { apollo };
});