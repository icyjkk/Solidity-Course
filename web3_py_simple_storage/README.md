# web3_py_simple_storage

Basically it is made to deploy and interact with our Contract in Python and Web3.py 

This is part of the [Solidity, Blockchain, and Smart Contract Course](https://www.youtube.com/watch?v=M576WGiDBdQ&t=7352s&ab_channel=freeCodeCamp.org)

## Getting Started

1. Clone this repo
2. Setup a [local ganache chain](https://www.trufflesuite.com/ganache)
3. Install requirements
```
 web3==5.23.1
 py-solc-x
```
4. Set your private keys and address, and adjust this section appropriately to testnet you want to work:
```
 # for connecting to ganache
 w3 = Web3(Web3.HTTPProvider("https://rinkeby.infura.io/v3/"))
 chain_id = 4
 my_address = "0x200e800d01a0E163944c48996238A27068b22b60"
 private_key = os.getenv("PRIVATE_KEY")
```
5. Run
```
 python deploy.py
```
**Make sure you have testnet ETH for whatever testnet you're on!**

> NOTE: rinkeby testnet has been deprecated. You should use other

## Thank you!
