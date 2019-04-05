pragma solidity ^0.4.24;

contract SolarChain {
    function SolarChain() public {}
    enum Assets {
        SmartMeter
    }
    Assets _makeTxn = Assets.SmartMeter;
    function makeTxn (
        string assetId,
        // 'assetId' is used to generate graph(experimental feature). It is reuqired, but you can fill with anything 
        string userID,
        string userRole,
        string userName,
        string txnType,
        int inReading,
        int outReading,
        int txnAmount,
        int txnCredit,
        int creditRate)
    public {}
}