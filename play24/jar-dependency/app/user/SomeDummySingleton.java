package user;

import play.Play;

public class SomeDummySingleton {

    private static SomeDummySingleton instance;

    private UserService userService;

    private SomeDummySingleton() {
        userService = Play.application().injector().instanceOf(UserService.class);
    }

    public User getUser() {
        return userService.getUser();
    }

    public static SomeDummySingleton instance() {
        if (instance == null) {
            synchronized (SomeDummySingleton.class) {
                if (instance == null) {
                    instance = new SomeDummySingleton();
                }
            }
        }
        return instance;
    }
}