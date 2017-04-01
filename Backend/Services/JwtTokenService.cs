using CoreApi.Config.Options;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace CoreApi.Services
{
    public class JwtTokenService
    {
        private ConfigOptions opts { get; set; }
        private SymmetricSecurityKey key { get; set; }
        private JwtSecurityTokenHandler handler { get; set; }

        public JwtTokenService(JwtSecurityTokenHandler handler, SymmetricSecurityKey key, IOptions<ConfigOptions> opts)
        {
            this.handler = handler;
            this.key = key;
            this.opts = opts.Value;
        }

        public string CreateToken(ClaimsIdentity identity)
        {
            var date = DateTime.Now;

            var token = new JwtSecurityToken(issuer: opts.Tokens.Issuer,
                audience: opts.Tokens.Audience,
                claims: identity.Claims,
                notBefore: date,
                expires: date.AddMonths(1),
                signingCredentials: new SigningCredentials(key, SecurityAlgorithms.HmacSha256));

            return handler.WriteToken(token);
        }
    }
}
