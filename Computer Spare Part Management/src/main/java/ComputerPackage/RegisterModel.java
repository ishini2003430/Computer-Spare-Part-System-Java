package ComputerPackage;

public class RegisterModel {
    private int registerid;
    private String fullname;
    private String email;
    private String username;
    private String password;

    public RegisterModel() {}

    public RegisterModel(int registerid, String fullname, String email, String username, String password) {
        this.registerid = registerid;
        this.fullname = fullname;
        this.email = email;
        this.username = username;
        this.password = password;
    }

    public int getRegisterid() { return registerid; }
    public void setRegisterid(int registerid) { this.registerid = registerid; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
