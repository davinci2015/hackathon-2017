using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Models.ApiModels
{
    public class LoginResultApiModel
    {
        public string AccessToken { get; set; }
        public string Avatar { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public int Money { get; set; }
        public string Nfc { get; set; }
    }
}
