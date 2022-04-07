import { ethers } from 'ethers'
import WalletBalance  from './WalletBalance'
function Home () {
    return (
        <div>
            <h3> Welcome to the Home Page </h3>
            <WalletBalance />
        </div>
    )
    
}