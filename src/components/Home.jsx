import { ethers } from 'ethers'
import WalletBalance  from './WalletBalance'
import { useState, useEffect } from 'react'
import schooNFT from '../../artifacts/contracts/schoolNFT.sol/school.json'

const provider = new ethers.providers.Web3Provider(window.ethereum)

const signer = provider.getSigner();

const contract = new ethers.Contract(contractAddress, schooNFT.abi, signer)

function Home () {
const [totalMinted, setTotalMited] = useState(0)
    
    useEffect(() => {
        getCount();
        
    }, [])

    const getCount = async () => {
        const count = await contract.totalSupply()
        setTotalMited(parseInt(count))
    }


    return (
        <div>
            <h3> Welcome to the Home Page </h3>
            <WalletBalance />
            <h1> School NFT </h1>
                {
                    Array(totalMinted + 1).fill(0).map((_, index) => {
                        <div key={index}>
                            <NFTimage tokenId={index} >

                            </NFTimage>
                            </div>

                    })}
        </div>
    )
    
}


function NFTimage ({ tokenId, getCount}) {
    const contentId = '';
    const metadataUri = `${contentId}/#{tokenId}.json`;
    const imageUri = `https://gateway.pinata.cloud/ipfs/${contentId}/${tokenId}.png`;

    const [isMinted, setIsMinted] = useState(false);
        
    useEffect(() => {
        getMintedStatus();

    }, [isMinted])


    const getMintedStatus = async () => {
        const isMinted = await contract.isContentOwned(metadataUri)
         console.log(isMinted)

    };

    const mintToken = async () => {
        const connection = contract.connect(signer);
        const addr = connection.address;
        const result = await contract.payToMint(addr, metadataUri, {
            value: ethers.utils.parseEther('0.05')
        });

        await result.wait()
        getMintedStatus();
        
    };

    async function getURI() {
        const uri = await contract.tokenURI(tokenId);
        console.log(uri);
    }

    return (
        <div>
            <img src={imageUri} alt={tokenId} />
            <button onClick={() => getURI()}> Get URI </button>
                <div>
                    <h5> ID #{tokenid} </h5>
                    {
                        isMinted ? (
                            <button onClick={() => getURI()}> Get URI </button>
                        ) : (
                            <button onClick={() => mintToken()}> Mint Token </button>
                        )
                    }
                </div>
        </div>

    )
}

export default Home;