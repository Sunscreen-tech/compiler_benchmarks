class Cardio {
    public static void main(String[] args) {
        EncInt man;
        EncInt smoking;
        EncInt diabetic;
        EncInt highBp;
        EncInt age;
        EncInt hdl;
        EncInt weight;
        EncInt height;
        EncInt physicalActivity;
        EncInt glassesAlcohol;

        EncInt cond1;
        EncInt cond2;
        EncInt cond3;
        EncInt cond4;
        EncInt cond5;
        EncInt cond6;
        EncInt cond7;
        EncInt cond8;
        EncInt cond9;
        EncInt cond10;
        EncInt result;

        man = PrivateTape.read();
        smoking = PrivateTape.read();
        diabetic = PrivateTape.read();
        highBp = PrivateTape.read();
        age = PrivateTape.read();
        hdl = PrivateTape.read();
        weight = PrivateTape.read();
        height = PrivateTape.read();
        physicalActivity = PrivateTape.read();
        glassesAlcohol = PrivateTape.read();

        cond1 = man & (age > 50);
        cond2 = (1 - man) & (age > 60);
        cond3 = smoking;
        cond4 = diabetic;
        cond5 = highBp;
        cond6 = hdl < 40;
        cond7 = weight > (height - 90);
        cond8 = physicalActivity < 30;
        cond9 = man & (glassesAlcohol > 3);
        cond10 = (1 - man) & (glassesAlcohol > 2);
    
        result = (((((((((cond1 + cond2) + cond3) + cond4) + cond5) + cond6) + cond7) + cond8) + cond9) + cond10);

        Processor.answer(result);
    }    
}
