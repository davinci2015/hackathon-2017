using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Models
{
    public class Tree
    {
        public Tree()
        {
            Date = DateTimeOffset.Now;
        }

        public long Id { get; set; }
        public KidUser Kid { get; set; }
        public decimal Lat { get; set; }
        public decimal Lng { get; set; }
        public string Image { get; set; }
        public DateTimeOffset Date { get; set; }
    }

    public class TreeApiModel
    {
        public KidUserTreeApiModel Kid { get; set; }
        public decimal Lat { get; set; }
        public decimal Lng { get; set; }
        public string Image { get; set; }
        public DateTimeOffset Date { get; set; }
    }

    public class TreeAddApiModel
    {
        [Required]
        public long KidId { get; set; }
        [Required]
        public decimal Lat { get; set; }
        [Required]
        public decimal Lng { get; set; }
        [Required]
        public IFormFile File { get; set; }
    }
}
