# TD05-Blockchain-Programming

# Tasks list - Create a Git repository & share it with the teacher

    git init
    git remote add origin "https://github.com/vlarreze/TD04-Blockchain.git"
    git add .
    git commit -m "Init commit"
    git push -u origin master
    
## Install Truffle & create a truffle project

Installation :

    npm install -g truffle

Requirements:

- NodeJS (v11.15 here)
- Windows

CREATING A PROJECT To use most Truffle commands, you need to run them against an existing Truffle project. So the first step is to create a Truffle project.

You can create a bare project template, but for those just getting started, you can use Truffle Boxes, which are example applications and project templates. We'll use the MetaCoin box, which creates a token that can be transferred between accounts:

Create a new directory for your Truffle project:

    mkdir MetaCoin 
    cd MetaCoin 

Download ("unbox") the MetaCoin box:

    truffle unbox metacoin 

> Note: You can use the truffle unbox command to download any of the other Truffle Boxes.

> Note: To create a bare Truffle project with no smart contracts included, use truffle init.

> Note: You can use an optional --force to initialize the project in the current directory regardless of its state (e.g. even if it contains other files or directories). This applies to both the init and unbox commands. Be careful, this will potentially overwrite files that exist in the directory.

Once this operation is completed, you'll now have a project structure with the following items:

contracts/: Directory for Solidity contracts migrations/: Directory for scriptable deployment files test/: Directory for test files for testing your application and contracts truffle-config.js: Truffle configuration file

Command:
To compile a Truffle project, change to the root of the directory where the project is located and then type the following into a terminal:

truffle compile:
Upon first run, all contracts will be compiled. Upon subsequent runs, Truffle will compile only the contracts that have been changed since the last compile. If you'd like to override this behavior, run the above command with the --all option.

## Create an ERC20 token contract

We use and implement the different functions from the ConsenSys repository:
https://github.com/ConsenSys/Tokens/blob/fdf687c69d998266a95f15216b1955a4965a0a6d/contracts/eip20/EIP20.sol

We execute the followings command:

    truffle develop
    truffle compile 
> in order to compile our contracts on ganache, when the contracts are compiled we can see deployed
on ganache contract interface

    truffle migrate 
> we migrate our contract to ganache, remix and Metamask

    truffle test 
> in order to do some tests before deploy the contract on a testnet

## Migrate to ganache

We use the function

    truffle migrate
> after launching ganache

We copy the first account key and import it in metamask to test our contract with remix.

## Implement customer white listing

In order to implement customer WhiteList, we create a second contract this contract have the following structure:
- function changeOwner() to change the owner of the WhiteList
- function getOwner() to get the owner of the WhiteList
- function whitelistAdress() to add someone (an adress) to the white list

Then we just inherit this contract on EIP20 and implement it on differents transaction functions.
