using Flurl;
using Flurl.Http;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Helpers.Authorization
{
    public class ExternalResponseModel
    {
        public string Access_Token { get; set; }
        public int Expires_In { get; set; }
        public string Token_Type { get; set; }
    }

    public class FacebookProfileModel
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string First_Name { get; set; }
        public string Last_Name { get; set; }
        public string Link { get; set; }
        public FacebookPictureInformation Picture { get; set; }
        public string Email { get; set; }
        public FacebookCoverPicture Cover { get; set; }
    }

    public class FacebookPictureInformation
    {
        public FacebookPictureInternal Data { get; set; }
    }

    public class FacebookPictureInternal
    {
        public bool Is_Silhouette { get; set; }
        public string Url { get; set; }
    }

    public class FacebookCoverPicture
    {
        public string Id { get; set; }
        public string Source { get; set; }
        public long Offset_Y { get; set; }
    }

    public class FacebookTokenExchanger
    {
        private const string TokenUri = "https://graph.facebook.com/v2.8/oauth/access_token";
        private const string ProfileUri = "https://graph.facebook.com/v2.8/me?fields=id,cover,email,first_name,last_name,link,name,picture.width(400).height(400)";

        public FacebookTokenExchanger()
        { }

        public async Task<ExternalResponseModel> ExchangeCodeForAccessToken(string code)
        {
            var pathSegments = new
            {
                client_id = 1416742531681673,
                client_secret = "a0c6bfd8a5b7b629f5d89e594de1debf",
                redirect_uri = "http://localhost:5000",
                code = code,
            };

            var response = await TokenUri.SetQueryParams(pathSegments).GetAsync();

            var content = await response.Content.ReadAsStringAsync();

            var jsonObject = JsonConvert.DeserializeObject<ExternalResponseModel>(content);

            return jsonObject;
        }

        public async Task<FacebookProfileModel> GetProfileData(string accessToken)
        {
            var pathSegments = new
            {
                access_token = accessToken
            };

            var response = await ProfileUri.SetQueryParams(pathSegments).GetAsync();

            var content = await response.Content.ReadAsStringAsync();

            var jsonObject = JsonConvert.DeserializeObject<FacebookProfileModel>(content);

            return jsonObject;
        }
    }
}


