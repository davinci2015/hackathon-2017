using AutoMapper;
using CoreApi.Database;
using CoreApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CoreApi.Controllers
{
    [Route("[controller]")]
    public class ItemsController : Controller
    {
        private IMapper mapper { get; set; }
        private DatabaseContext ctx { get; set; }

        public ItemsController(DatabaseContext ctx, IMapper mapper)
        {
            this.ctx = ctx;
            this.mapper = mapper;
        }

        [HttpGet("")]
        public async Task<IActionResult> GetAll()
        {
            var items = await ctx.Items.Include(x => x.Parts)
                .Include(x => x.Links).ToListAsync();

            var mapped = mapper.Map<IEnumerable<RecycleItemApiModel>>(items);

            return Ok(mapped);
        }

        [HttpGet("single/{id}")]
        public async Task<IActionResult> Get(string id)
        {
            var item = await ctx.Items.Include(x => x.Parts)
                .Include(x => x.Links)
                .FirstAsync(x => x.BarCode == id);

            return Ok(mapper.Map<RecycleItemApiModel>(item));
        }

        [HttpPost("")]
        public async Task<IActionResult> Create([FromBody]RecycleItemApiModel model)
        {
            var mapped = mapper.Map<RecycleItem>(model, opts => opts.BeforeMap((src, _) =>
            {
                var mod = model as RecycleItemApiModel;
                mod.Id = 0;
                foreach (var item in mod.Links)
                    item.Id = 0;
                foreach (var link in mod.Parts)
                    link.Id = 0;
            }));
            ctx.Items.Add(mapped);

            try
            {
                await ctx.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return BadRequest();
            }

            return Ok(model);
        }
    }
}
