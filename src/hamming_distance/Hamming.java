class Cardio {
    public static void main(String[] args) {
        EncInt x;
        EncInt y;
        EncInt result;
        EncInt xor;
        EncInt shift;
        EncInt masked;
        int len;

        result = 0;
        
        len = PublicTape.read();

        for (int i = 0; i < len; i++) {
            x = PrivateTape.read();
            y = PrivateTape.read();
            xor = x ^ y;

            for (int j = 0; j < 8; j++) {
                shift = xor >> j;
                masked = shift & 1;
                result = result + masked;
            }
        }

        Processor.answer(result);
    }    
}
