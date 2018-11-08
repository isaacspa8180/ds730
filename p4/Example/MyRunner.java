public class MyRunner {
    public static void main(String[] args) {
        MyThread lightweight = new MyThread();
        lightweight.start();
        MyThread lightweightTwo = new MyThread();
        lightweightTwo.start();
        while (lightweight.isAlive() || lightweightTwo.isAlive()) {
            System.out.println("still working");
        }
    }
}
