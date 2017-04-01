using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using System.Collections;
using System.Collections.Generic;

namespace CoreApi.Models
{
    public class User : IdentityUser
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        public string DeviceId { get; set; }
        public string Avatar { get; set; }
        public int Money { get; set; }
        public string Nfc { get; set; }

        public ICollection<EventsUsers> EventUsers { get; set; }
        //public ICollection<Cleaning> Cleanings { get; set; }
    }

    public class UserApiModel
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        public string DeviceId { get; set; }
        public string Avatar { get; set; }
        public int Money { get; set; }
        public string Nfc { get; set; }
    }
}
