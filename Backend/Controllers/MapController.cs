using CoreApi.Database;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Controllers
{
    [Route("[controller]")]
    public class MapController : Controller
    {
        private DatabaseContext ctx { get; set; }

        public MapController(DatabaseContext ctx)
        {
            this.ctx = ctx;
        }

        [HttpGet("")]
        public async Task<IActionResult> MapData()
        {
            var data = await ctx.Events.Select(x => new { x.Lat, x.Lng })
                .ToListAsync();

            return Ok(data);
        }
    }
}
