package source;

/**
 * Created by hongyangjiang on 8/5/16.
 */
public class User {
    private String id;
    private String first_name;
    private String last_name;
    private String email;
    private String password;

    public String setEmail(String email) {
        this.email = email;
        return email;
    }

    public String getEmail() {
        return email;
    }

    public String setPassword(String password) {
        this.password = password;
        return password;
    }

    public String getPassword() {
        return password;
    }

    public String setID(String id) {
        this.id = id;
        return id;
    }

    public String getID() {
        return id;
    }

    public String setFirst_name(String first_name) {
        this.first_name = first_name;
        return first_name;
    }

    public String getFirst_name() {
        return first_name;
    }

    public String setLast_name(String last_name) {
        this.last_name = last_name;
        return last_name;
    }

    public String getLast_name() {
        return last_name;
    }

}
