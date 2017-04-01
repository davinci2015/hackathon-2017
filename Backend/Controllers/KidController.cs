using AutoMapper;
using CoreApi.Database;
using CoreApi.Models;
using CoreApi.Websockets;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR.Infrastructure;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace CoreApi.Controllers
{
    [Route("[controller]")]
    public class KidController : Controller
    {
        private IConnectionManager conManager { get; set; }
        private IMapper mapper { get; set; }
        private DatabaseContext db { get; set; }

        public KidController(DatabaseContext db, IMapper mapper, IConnectionManager conManager)
        {
            this.db = db;
            this.mapper = mapper;
            this.conManager = conManager;
        }

        [HttpPost("")]
        public async Task<IActionResult> Create([FromBody]KidUserApiModel model)
        {
            if (!ModelState.IsValid)
                return BadRequest();

            var mapped = mapper.Map<KidUser>(model);

            db.Kids.Add(mapped);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return BadRequest();
            }

            return Ok(mapped);
        }

        [HttpPut("{id:long}")]
        public async Task<IActionResult> Update(long id)
        {
            if (db.Kids.Any(x => x.Id == id && x.IsFinished))
                return Ok();

            var kid = db.Kids.FirstOrDefault(x => x.Id == id);
            if (kid == null)
                return NotFound(new { Error = "No kid user defined with that id" });

            kid.IsFinished = true;

            try
            {
                await db.SaveChangesAsync();
            } catch(Exception e)
            {
                Console.WriteLine(e.Message);
                return BadRequest();
            }

            //conManager.GetHubContext<ChatHub>()
            //    .Clients
            //    .All
            //    .kidFinished(new { id });

            return Ok(); 
        }

        [HttpGet("notree")]
        public async Task<IActionResult> KidsNoTree()
        {
            var kids = await db.Kids.Include(x => x.Trees)
                .Where(x => x.IsFinished == true)
                .ToListAsync();

            var mapped = mapper.Map<IEnumerable<KidUserNoTreeApiModel>>(kids);

            var model = new {
                KidsCount = await db.Kids.CountAsync(),
                TreeCount = await db.Trees.CountAsync(),
                KidsWithoutTrees = mapped
            };

            return Ok(model);
        }

        [HttpPost("addtree")]
        public async Task<IActionResult> AddTree(TreeAddApiModel model)
        {
            var lat = Request.Query["lat"].ToString().Replace('.', ',');
            var lng = Request.Query["lng"].ToString().Replace('.', ',');
            var kidid = Request.Query["id"];

            model.Lat = decimal.Parse(lat);
            model.Lng = decimal.Parse(lng);
            model.KidId = long.Parse(kidid);

            if (!ModelState.IsValid)
                return BadRequest();

            var kid = db.Kids.Include(x => x.Trees).FirstOrDefault(x => x.Id == model.KidId);

            if (kid == null)
                return BadRequest();
            if (kid.Trees.Count == 3)
                return Ok();

            var mapped = mapper.Map<Tree>(model);
            mapped.Kid = kid;
            var file = Path.GetRandomFileName().Split('.').First();
            var path = $"{new DirectoryInfo(Directory.GetCurrentDirectory()).FullName}/wwwroot/{file}.jpg";

            using (var stream = System.IO.File.Create(path))
            {
                await model.File.CopyToAsync(stream);
                await stream.FlushAsync();
            }
            mapped.Image = $"http://localhost:5000/{file}.jpg";
            db.Trees.Add(mapped);

            try
            {
                await db.SaveChangesAsync();
            } catch(Exception e)
            {
                Console.WriteLine(e.Message);
                return BadRequest();
            }

            conManager.GetHubContext<ChatHub>()
                .Clients
                .All
                .treePlanted(new { lat = model.Lat, lng = model.Lng });

            return Ok(model);
        }
    }
}
