using System.ComponentModel.DataAnnotations;

namespace lab3b_vd.DTO.Admin;

public class RegisterDto
{
    [MinLength(2, ErrorMessage = "name should be more then 2 letters")]
    [MaxLength(20, ErrorMessage = "name should be less then 20 letters")]
    public string Username { get; set; }

    [MinLength(2, ErrorMessage = "name should be more then 2 letters")]
    [MaxLength(20, ErrorMessage = "name should be less then 20 letters")]
    public string Password { get; set; }
}
