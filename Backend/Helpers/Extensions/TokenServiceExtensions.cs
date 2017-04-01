using CoreApi.Models;
using CoreApi.Models.ApiModels;
using CoreApi.Services;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace CoreApi.Helpers.Extensions
{
    public static class TokenServiceExtensions
    {
        public static LoginResultApiModel CreateAccessToken(this JwtTokenService service, User user)
        {
            return new LoginResultApiModel
            {
                Avatar = user.Avatar,
                Email = user.Email,
                Name = user.Name,
                Surname = user.Surname,
                Money = user.Money,
                Nfc = user.Nfc,
                AccessToken = service.CreateToken(new ClaimsIdentity(new[] {
                    new Claim(ClaimTypes.NameIdentifier, user.Id),
                    //new Claim(ClaimTypes.Name, user.usernam),
                    //new Claim(JwtRegisteredClaimNames.Sub, "test@zeromolecule.com"),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
                }))
            };
        }
    }
}
