package service;

import user.User;
import user.UserService;

public class UserServiceImpl implements UserService {

    public User getUser() {
        return new User().setAge(33).setRole("admin_56").setName("User#333");
    }
}
