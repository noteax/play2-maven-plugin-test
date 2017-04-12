import com.google.inject.AbstractModule;
import service.UserServiceImpl;
import user.UserService;

public class AppModule extends AbstractModule {

    protected void configure() {
        bind(UserService.class).to(UserServiceImpl.class);
    }
}