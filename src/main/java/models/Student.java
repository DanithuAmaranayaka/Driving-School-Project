package models;

public class Student {
    private int studentId;
    private String name;
    private String nic;
    private String phoneNumber;
    private String address;
    private String licenseType;
    private String username;
    private String password;

    public Student() {}

    public Student(int studentId, String name, String nic, String phoneNumber, String address, String licenseType, String username, String password) {
        this.studentId = studentId;
        this.name = name;
        this.nic = nic;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.licenseType = licenseType;
        this.username = username;
        this.password = password;
    }

    // Getters and Setters
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getLicenseType() { return licenseType; }
    public void setLicenseType(String licenseType) { this.licenseType = licenseType; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
