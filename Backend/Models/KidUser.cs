using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Models
{
    public class KidUser
    {
        public KidUser()
        {
            this.IsFinished = false;
        }

        public long Id { get; set; }
        public string Name { get; set; }
        public bool IsFinished { get; set; }
        public ICollection<Tree> Trees { get; set; }
    }

    public class KidUserApiModel
    {
        [Required]
        public string Name { get; set; }
        //[Required]
        //public bool IsFinished { get; set; }
    }

    public class KidUserTreeApiModel
    {
        public string Name { get; set; }
        public bool IsFinished { get; set; }
        public long TreeId { get; set; }
    }

    public class KidUserNoTreeApiModel
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public bool IsFinished { get; set; }
        public int TreeCount { get; set; }
    }
}
