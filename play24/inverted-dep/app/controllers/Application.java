package controllers;

import play.libs.Json;
import play.mvc.*;

import user.User;
import user.SomeDummySingleton;
import views.html.*;

public class Application extends Controller {

    public Result currentUser() {
        User user = SomeDummySingleton.instance().getUser();
        return ok(Json.toJson(user));
    }

    public Result index() {
        User user = SomeDummySingleton.instance().getUser();
        return ok(
            index.render(user)
        );
    }

}
