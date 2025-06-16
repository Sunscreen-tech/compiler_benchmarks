class ChiSq {

	public static void main(String[] args){
		EncInt n0;
		EncInt n1;
		EncInt n2;
        EncInt a;
        EncInt x;
        EncInt y;
        EncInt alpha;
        EncInt beta1;
        EncInt beta2;
        EncInt beta3;
		n0 = PrivateTape.read();
        n1 = PrivateTape.read();
        n2 = PrivateTape.read();

        a = (4 * (n0 * n2)) - (n1 * n1);
        x = (2 * n0) + n1;
        y = (2 * n2) + n1;
        
        alpha = a * a;
        beta1 = 2 * (x * x);
        beta2 = x * y;
        beta3 = 2 * (y * y);

		//Processor.answer(alpha);
        //Processor.answer(beta1);
        //Processor.answer(beta2);
        Processor.answer(beta3);
	}

}
