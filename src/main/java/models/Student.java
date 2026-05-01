package models;

public class Student extends Person {
    private int studentId;
    private String nic;
    private String address;
    private String licenseType;
    private String username;
    private String password;

    public Student() {
        super();
    }

    public Student(int studentId, String name, String nic, String phoneNumber, String address, String licenseType, String username, String password) {
        super(name, phoneNumber);
        this.studentId = studentId;
        this.nic = nic;
        this.address = address;
        this.licenseType = licenseType;
        this.username = username;
        this.password = password;
    }

    // Getters and Setters
    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getLicenseType() { return licenseType; }
    public void setLicenseType(String licenseType) { this.licenseType = licenseType; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    @Override
    public String getRole() {
        return "Student";
    }
}
