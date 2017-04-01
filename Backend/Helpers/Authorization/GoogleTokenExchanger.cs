using Flurl.Http;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Helpers.Authorization
{
    public class GoogleProfileModel
    {
        public string Sub { get; set; }
        public string Name { get; set; }
        public string Given_Name { get; set; }
        public string Family_Name { get; set; }
        public string Profile { get; set; }
        public string Picture { get; set; }
        public string Email { get; set; }
    }

    public class GoogleTokenExchanger
    {
        private const string TokenUri = "https://accounts.google.com/o/oauth2/token";
        private const string ProfileUri = "https://www.googleapis.com/plus/v1/people/me/openIdConnect";

        public GoogleTokenExchanger()
        { }

        public async Task<ExternalResponseModel> ExchangeCodeForAccessToken(string code)
        {
            var pathSegments = new
            {
                code = code,
                client_id = "",
                client_secret = "",
                redirect_uri = "",
                grant_type = "authorization_code"
            };

            var response = await TokenUri.PostUrlEncodedAsync(pathSegments);

            var content = await response.Content.ReadAsStringAsync();

            var jsonObject = JsonConvert.DeserializeObject<ExternalResponseModel>(content);

            return jsonObject;
        }

        public async Task<GoogleProfileModel> GetProfileData(string accessToken)
        {
            var response = await ProfileUri.WithOAuthBearerToken(accessToken).GetAsync();

            var content = await response.Content.ReadAsStringAsync();

            var jsonObject = JsonConvert.DeserializeObject<GoogleProfileModel>(content);

            jsonObject.Picture = jsonObject.Picture.Split(new string[] { "sz" }, StringSplitOptions.None)[0] + "sz=400";

            return jsonObject;
        }
    }
}
