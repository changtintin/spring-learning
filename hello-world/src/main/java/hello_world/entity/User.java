package hello_world.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String username;

    private Boolean isDeleted;

    public String getUserName(){
        return username;
    }

    public Boolean getIsDeleted(){
        return isDeleted;
    }

    public void setUserName(String name){
        this.username = name;
    }

    public void setIsDeleted(Boolean isDeleted){
        this.isDeleted = isDeleted;
    }
}
