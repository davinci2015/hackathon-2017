using Microsoft.AspNetCore.Authorization;

namespace CoreApi.Attributes
{
    public class JwtAuthorizeAttribute : AuthorizeAttribute
    {
        public JwtAuthorizeAttribute()
        {
            ActiveAuthenticationSchemes = "Bearer";
        }
    }
}
