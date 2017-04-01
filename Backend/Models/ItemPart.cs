using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Models
{
    public class ItemPart
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Image { get; set; }
        public ItemType Type { get; set; }

        public RecycleItem Item { get; set; }
    }

    public class ItemPartApiModel
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Image { get; set; }
        public ItemType Type { get; set; }
    }


    public enum ItemType
    {
        Plastika = 0,
        Papir = 1,
        Staklo = 2,
        Aluminij = 3
    }
}
