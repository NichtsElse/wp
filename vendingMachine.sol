
pragma solidity ^0.5.0;

contract VendingMachine {

    // state variables
    address public owner;
    mapping (address => uint) public donutBalances;

     // set pemilik sebagai alamat yang menyebarkan kontrak
     // set saldo mesin penjual awal menjadi 100
    constructor() public {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }

    // Biarkan pemiliknya restock mesin penjual otomatis
    function restock(uint amount) public {
        require(msg.sender == owner, "Hanya pemilik yang dapat restock.");
        donutBalances[address(this)] += amount;
    }

    // Beli donat dari mesin penjual otomatis
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 1 ether, "Anda harus membayar minimal 1 ETH per donat");
        require(donutBalances[address(this)] >= amount, "Stok donat tidak cukup untuk menyelesaikan pembelian ini");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }
}
