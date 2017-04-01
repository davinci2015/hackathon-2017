using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Models.ApiModels
{
    public class EventsApiModel
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Image { get; set; }
        public DateTimeOffset StartDate { get; set; }
        public string CreatedBy { get; set; }
        public decimal Lat { get; set; }
        public decimal Lng { get; set; }
        public int Count { get; set; }
    }
}
