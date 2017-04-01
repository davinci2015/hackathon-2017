using AutoMapper;
using CoreApi.Database;
using CoreApi.Models;
using CoreApi.Websockets;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR.Infrastructure;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CoreApi.Controllers
{
    [Route("[controller]")]
    public class TreeController : Controller
    {
        private IMapper mapper { get; set; }
        private DatabaseContext db { get; set; }

        public TreeController(DatabaseContext db, IMapper mapper)
        {
            this.db = db;
            this.mapper = mapper;
        }

        [HttpGet("test")]
        public IActionResult Index()
        {
            var lat = 44.764515;
            var lng = 20.459931;
            var conManager = this.HttpContext.RequestServices.GetService(typeof(IConnectionManager)) as IConnectionManager;

            conManager.GetHubContext<ChatHub>()
                .Clients
                .All
                .treePlanted(new { lat, lng });

            return Ok();
        }

        [HttpGet("")]
        public async Task<IActionResult> GetTrees()
        {
            var trees = await db.Trees
                .Include(x => x.Kid)
                .ToListAsync();

            var mapped = mapper.Map<IEnumerable<TreeApiModel>>(trees);

            return Ok(mapped);
        }
    }
}
