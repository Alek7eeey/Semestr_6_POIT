using Lab_4.Models;

namespace Lab_4.Utils
{
    public static class Security
    {
        public static bool CheckIsAdmin(HttpContext context)
        {
            return context.Session.Get("isAdmin") != null;
        }
        public static bool CheckIsCommentUser(HttpContext context, Comments comment)
        {
            if (context.Session.Get("isAdmin") != null)
            {
                return true;
            }

            if (comment.SessionId == context.Session.Id && comment.Role == "user")
            {
                return true;
            }

            return false;
        }
    }
}
