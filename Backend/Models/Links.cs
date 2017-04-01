using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Models
{
    public class Links
    {
        public long Id { get; set; }
        public string Url { get; set; }

        public RecycleItem Item { get; set; }
    }

    public class LinksApiModel
    {
        public long Id { get; set; }
        public string Url { get; set; }
    }
}
