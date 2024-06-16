using System.ComponentModel.DataAnnotations;

namespace Lab_3b.DTO.Admin;

public class RegisterDto
{
    [MinLength(2, ErrorMessage = "name should be more then 2 letters")]
    [MaxLength(20, ErrorMessage = "name should be more then 2 letters")]
    public string Username { get; set; }

    [MinLength(2, ErrorMessage = "password should be from 2 to 20 elements")]
    [MaxLength(20, ErrorMessage = "password should be from 2 to 20 elements")]
    public string Password { get; set; }
}
