// implementing proof of users registration with Merkle tree , Designed by Abolfazl Iraninasab

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Register{

    bytes32 [] public hashes ;
    bytes32 [] public merkleHash ;
    uint leafNodes ;
    uint registered ;

    function register()public {
        require(true);
        addMerkle(keccak256(abi.encodePacked(msg.sender)));
    }

  function addMerkle(bytes32 _userHash ) private {
        
        if(registered < leafNodes){
            hashes[registered] = _userHash;
        }else if(leafNodes == 0){
            hashes.push(_userHash);
            leafNodes++ ;
            registered++ ;
        }else{
            hashes.push(_userHash);
            for(uint i = 0 ; i < leafNodes - 1 ; i++){
                hashes.push();
            }
            leafNodes *=2 ;
            registered++ ;
        }
        
        updateMerkle();
    }

    function updateMerkle()public {
        uint n = leafNodes;
        uint offset = 0;
        merkleHash = hashes ;

        while (n > 0) {
            for (uint i = 0; i < n - 1; i += 2) {
                merkleHash.push(
                    keccak256(abi.encodePacked(merkleHash[offset + i], merkleHash[offset + i + 1]))
                );
            }
            offset += n;
            n = n / 2;
        }
    }

    function getMerkleHash()public view returns(bytes32 [] memory ){
        return merkleHash ;
    }

    function getHashes()public view returns(bytes32 [] memory ){
        return hashes ;
    }

    function getMerkleProofs(bytes32 _userHash)public view returns(bytes32[] memory){
        bytes32[] memory merkleProofs ;
        for(uint i = 0 ; i < registered ; i++ ){
            if(_userHash == hashes[i]){
                break ;
            }
        }

        return merkleProofs ;
    }
}

// finish