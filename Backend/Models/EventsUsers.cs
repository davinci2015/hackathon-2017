using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Models
{
    public class EventsUsers
    {
        public string UserId { get; set; }
        public User User { get; set; }

        public long EventId { get; set; }
        public Event Event { get; set; }
    }
}
