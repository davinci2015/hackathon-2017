using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CoreApi.Models
{
    public class Event
    {
        public Event()
        {
            this.EventUsers = new HashSet<EventsUsers>();
        }

        public long Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Image { get; set; }
        public DateTimeOffset StartDate { get; set; }
        public string CreatedBy { get; set; }
        public decimal Lat { get; set; }
        public decimal Lng { get; set; }
        
        public ICollection<EventsUsers> EventUsers { get; set; }
    }

    public class CreateEventApiModel
    {
        [Required]
        public string Name { get; set; }
        [Required]
        public string Description { get; set; }
        [Required]
        public string Image { get; set; }
        [Required]
        public decimal Lat { get; set; }
        [Required]
        public decimal Lng { get; set; }
    }
}
