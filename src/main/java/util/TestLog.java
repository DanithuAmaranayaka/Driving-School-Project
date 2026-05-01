package util;

public class TestLog {
    public static void main(String[] args) {
        System.out.println("Testing LogUtil...");
        LogUtil.logAction("Test log entry from verification script");
        System.out.println("Log entry written. Please check system_log.txt");
    }
}
