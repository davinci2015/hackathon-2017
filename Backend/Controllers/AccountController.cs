using CoreApi.Attributes;
using CoreApi.Helpers.Authorization;
using CoreApi.Models;
using CoreApi.Models.ApiModels;
using CoreApi.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using CoreApi.Helpers.Extensions;
using AutoMapper;

namespace CoreApi.Controllers
{
    [Route("[controller]")]
    public class AccountController : Controller
    {
        private IMapper mapper { get; set; }
        private UserManager<User> userManager { get; set; }
        private GoogleTokenExchanger googleTokenExchanger { get; set; }
        private FacebookTokenExchanger fbTokenExchanger { get; set; }
        private JwtTokenService tokenService { get; set; }

        public AccountController(JwtTokenService tokenService, FacebookTokenExchanger fbTokenExchanger, GoogleTokenExchanger googleTokenExchanger, UserManager<User> userManager, IMapper mapper)
        {
            this.tokenService = tokenService;
            this.fbTokenExchanger = fbTokenExchanger;
            this.googleTokenExchanger = googleTokenExchanger;
            this.userManager = userManager;
            this.mapper = mapper;
        }

        [HttpPost("login/facebook")]
        public async Task<IActionResult> FacebookLogin([FromBody]LoginApiModel model)
        {
            FacebookProfileModel profile = null;

            await this.TryCatchExecute(async() =>
            {
                if (model.AccessToken != null)
                    profile = await fbTokenExchanger.GetProfileData(model.AccessToken);
                else
                    profile = await fbTokenExchanger.GetProfileData((await fbTokenExchanger.ExchangeCodeForAccessToken(model.Code)).Access_Token);
            });

            if (profile == null)
                return BadRequest();

            var user = await userManager.FindByLoginAsync("facebook", profile.Id);

            if (user != null)
                return Ok(tokenService.CreateAccessToken(user));

            var mapped = mapper.Map<User>(profile);
            var result = await userManager.CreateAsync(mapped);

            if (result.Succeeded)
                if((await userManager.AddLoginAsync(mapped, new UserLoginInfo("facebook", profile.Id, "FACEBOOK"))).Succeeded)
                    return Ok(tokenService.CreateAccessToken(mapped));
                
            return BadRequest();
        }

        [HttpPost("login/google")]
        public async Task<IActionResult> GoogleLogin(LoginApiModel model)
        {
            GoogleProfileModel profile = null;

            await this.TryCatchExecute(async () =>
            {
                if (model.AccessToken != null)
                    profile = await googleTokenExchanger.GetProfileData(model.AccessToken);
                else
                    profile = await googleTokenExchanger.GetProfileData((await googleTokenExchanger.ExchangeCodeForAccessToken(model.Code)).Access_Token);
            });

            if (profile == null)
                return BadRequest();

            var user = await userManager.FindByLoginAsync("google", profile.Sub);

            if (user != null)
                return Ok(tokenService.CreateAccessToken(user));

            var mapped = mapper.Map<User>(profile);
            var result = await userManager.CreateAsync(mapped);

            if (result.Succeeded)
                if ((await userManager.AddLoginAsync(mapped, new UserLoginInfo("google", profile.Sub, "GOOGLE"))).Succeeded)
                    return Ok(tokenService.CreateAccessToken(mapped));

            return BadRequest();
        }

        [HttpPost(nameof(Protected))]
        [JwtAuthorize]
        public IActionResult Protected()
        {
            return Ok(new { Message = "Protected route" });
        }
    }
}
