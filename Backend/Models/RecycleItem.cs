using CoreApi.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Models
{
    public class RecycleItem
    {
        public RecycleItem()
        {
            this.Links = new HashSet<Links>();
            this.Parts = new HashSet<ItemPart>();
        }

        public long Id { get; set; }
        public string Name { get; set; }
        public string BarCode { get; set; }
        public string Image { get; set; }

        public ICollection<ItemPart> Parts { get; set; }
        public ICollection<Links> Links { get; set; }

        public static void CreateDefault(DatabaseContext ctx)
        {
            if (ctx.Items.Any())
                return;

            var item = new RecycleItem
            {
                Name = "Nestle plastična boca",
                BarCode = "231edw313"
            };

            var parts = new[] {
                new ItemPart
                {
                    Name = "Čep",
                    Type = ItemType.Plastika
                },
                new ItemPart
                {
                    Name = "Etiketa",
                    Type = ItemType.Papir
                },
                new ItemPart
                {
                    Name = "Boca",
                    Type = ItemType.Plastika
                }
            };

            var links = new[]
            {
                new Links
                {
                    Url = "https://www.youtube.com/watch?v=_eolmWGRYCc"
                }
            };

            foreach (var part in parts)
                item.Parts.Add(part);
            foreach (var link in links)
                item.Links.Add(link);

            ctx.Items.Add(item);
            ctx.SaveChanges();
        }
    }

    public class RecycleItemApiModel
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string BarCode { get; set; }
        public string Image { get; set; }

        public IEnumerable<ItemPartApiModel> Parts { get; set; }
        public IEnumerable<LinksApiModel> Links { get; set; }
    }
}
