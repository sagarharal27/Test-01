public class ProcessBuilderDemo {

    @InvocableMethod
    public static void method1(List <Id> accountIdList) {
        System.debug(' *** Account Id List size ***' + accountIdList.size());
        System.debug(' *** Account Id List sent via Process Builder ***' + accountIdList);
        
    }

}