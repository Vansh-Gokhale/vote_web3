## 🗳️ vote_web3 — Decentralized Voting Platform on Educhain

> Secure, transparent, and tamper-proof voting system powered by Ethereum smart contracts and Educhain.

---



---

### 🔗 Features

- ✅ Fully decentralized voting via Ethereum smart contracts  
- 🧑‍💼 Admin panel for creating proposals  
- 🗳️ Voter interface to cast votes  
- ⛓️ Deploys on [Educhain](https://educhain.network/) (testnet/mainnet)  
- 🦊 MetaMask integration for wallet interactions  
- 🔐 Tamper-proof voting logic

---

### 🧱 Tech Stack

| Layer      | Tech                                   |
|------------|----------------------------------------|
| Frontend   | HTML, CSS, JavaScript                  |
| Backend    | Solidity, Hardhat                      |
| Blockchain | Educhain (EVM-compatible)              |
| Wallet     | MetaMask + ethers.js                   |
| Deployment | Hardhat + Educhain RPC                 |

---

### 📁 Project Structure

```bash
vote_web3/
├── contracts/
│   └── Voting.sol          # Smart contract logic
├── scripts/
│   └── deploy.js           # Deployment script
├── frontend/
│   └── index.html          # UI logic
├── .env                    # Private key + RPC (never push)
├── hardhat.config.js       # Network and Solidity config
└── README.md
```

---

### ⚙️ Setup & Installation

```bash
git clone https://github.com/Vansh-Gokhale/vote_web3.git
cd vote_web3

# Install dependencies
npm install

# Compile contracts
npx hardhat compile
```

---

### 🔐 .env File (Create in root)

```env
EDUCHAIN_RPC=https://rpc.open-campus-codex.gelato.digital
PRIVATE_KEY=your_private_key_without_0x
```

---

### 🚀 Deploy Smart Contract

```bash
npx hardhat run scripts/deploy.js --network educhain
```

Once deployed, copy the **contract address** and update your frontend `index.html` or JS logic.

---

### 🌐 Connect to MetaMask

In the frontend JavaScript:

```js
const provider = new ethers.providers.Web3Provider(window.ethereum);
await provider.send("eth_requestAccounts", []);
const signer = provider.getSigner();
```

---

### 📦 To-Do / Future Enhancements

- [ ] Add real-time vote count updates
- [ ] Add NFT-based voter verification
- [ ] IPFS for decentralized frontend hosting
- [ ] DAO integration for proposal governance

---

### 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to fork the repo and submit a PR.

---

### 🛡️ License

MIT © 2025 [Vansh Gokhale](https://github.com/Vansh-Gokhale)

DEPLOYED CONTRACT ADDRESS : 0x20070660f1bf643ab60e62289eb0d9770451e261
