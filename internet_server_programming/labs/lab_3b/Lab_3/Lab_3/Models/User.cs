using Microsoft.AspNetCore.Identity;

namespace Lab_3b.Models;

public class User : IdentityUser
{
    public User() : base()
    {

    }

    public User(User user)
    {
        Id = user.Id;
        UserName = user.UserName;
        PasswordHash = user.PasswordHash;
    }
}
