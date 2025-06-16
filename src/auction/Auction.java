class Auction {
    public static void main(String[] args) {
        EncInt maxBid;
        EncInt maxIdx;
        EncInt curBid;

        int len = PublicTape.read();

        maxBid = PrivateTape.read();
        maxIdx = maxBid;

        for (int i = 1; i < len; i++) {
            curBid = PrivateTape.read();

            maxBid = (curBid > maxBid) ? curBid : maxBid;
            maxIdx = (curBid > maxBid) ? curBid : maxIdx;
        }
        
        Processor.answer(maxBid);
    }   
}
