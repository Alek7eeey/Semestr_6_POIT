using System.ComponentModel.DataAnnotations;

namespace Lab_3b.DTO.Admin;

public class ChangePasswordDto
{
    public string Password { get; set; }
    [MinLength(2, ErrorMessage = "password lenght should be from to 2 to 20 elements")]
    [MaxLength(20, ErrorMessage = "password lenght should be from to 2 to 20 elements")]
    public string NewPassword { get; set; }
}
