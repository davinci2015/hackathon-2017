using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Models
{
    public class Cleaning
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public decimal Lat { get; set; }
        public decimal Lng { get; set; }
        public string ImageBefore { get; set; }
        public string ImageAfter { get; set; }

        //public User User { get; set; }
    }

    public class CleaningApiModel
    {
        [Required]
        public string Name { get; set; }
        [Required]
        public decimal Lat { get; set; }
        [Required]
        public decimal Lng { get; set; }
        [Required]
        public string ImageBefore { get; set; }
        [Required]
        public string ImageAfter { get; set; }
    }

    public class CleaningIdApiModel: CleaningApiModel
    {
        public long Id { get; set; }
    }
}
