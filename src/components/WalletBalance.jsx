import { useState } from 'react'
import { ethers } from 'ethers'


function WalletBalance() {
    const [balance, setBalance] = useState()

    const getBalance = async () => {
        const [account] = await window.ethereum.request({ method: 'eth_requestAccounts' })
        const provider = new ethers.providers.Web3Provider(window.ethereum)

        const balance = await provider.getBalance()

        setBalance(ethers.utils.formatEther(balance))

    };
    return (
        <div className='card'>
            <div>
                <h3> Wallet Balance {balance} </h3>
                <button onClick={getBalance}> Get Balance </button>
            </div>
        </div>
    )

};

export default WalletBalance;